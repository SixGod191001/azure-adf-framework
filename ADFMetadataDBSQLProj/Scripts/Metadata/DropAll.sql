IF OBJECT_ID(N'tempdb..##DropSchemaAndObjects') IS NOT NULL DROP PROCEDURE ##DropSchemaAndObjects;
GO

CREATE PROCEDURE ##DropSchemaAndObjects
	(
    @SchemaName NVARCHAR(128)
	)
AS
BEGIN
    DECLARE @ObjectName NVARCHAR(128);
    DECLARE @ObjectType CHAR(2);
    DECLARE @SQLStatement NVARCHAR(MAX);

    -- 创建游标
	DECLARE ObjectCursor CURSOR FOR
	SELECT
	    o.name AS ObjectName,
	    o.type AS ObjectType
	FROM
	    sys.objects o
	    INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
	WHERE
	    s.name = @SchemaName
    AND o.type IN ('UQ', 'C', 'D', 'PK', 'F', 'U', 'V', 'FN', 'P', 'SN');


    -- 打开游标
    OPEN ObjectCursor;

    -- 抓取第一条记录
    FETCH NEXT FROM ObjectCursor INTO @ObjectName, @ObjectType;

    -- 循环删除对象
    WHILE @@FETCH_STATUS = 0
    BEGIN
	    -- Truncate the table before dropping
        IF @ObjectType = 'U'  -- Check if the object is a table
        BEGIN
            SET @SQLStatement = 'TRUNCATE TABLE [' + @SchemaName + '].[' + @ObjectName + ']';
            EXEC sp_executesql @SQLStatement;
        END

        SET @SQLStatement = 'DROP ' +
            CASE @ObjectType
                WHEN 'UQ' THEN 'CONSTRAINT'
                WHEN 'C' THEN 'CONSTRAINT'
                WHEN 'D' THEN 'CONSTRAINT'
                WHEN 'PK' THEN 'CONSTRAINT'
                WHEN 'F' THEN 'CONSTRAINT'
                WHEN 'U' THEN 'TABLE'
                WHEN 'V' THEN 'VIEW'
                WHEN 'FN' THEN 'FUNCTION'
                WHEN 'P' THEN 'PROCEDURE'
                WHEN 'SN' THEN 'SYNONYM'
            END +
            ' [' + @SchemaName + '].[' + @ObjectName + ']'


        -- 执行删除语句
        EXEC sp_executesql @SQLStatement

        -- 抓取下一条记录
        FETCH NEXT FROM ObjectCursor INTO @ObjectName, @ObjectType
    END

    -- 关闭游标
    CLOSE ObjectCursor

    -- 释放游标
    DEALLOCATE ObjectCursor

    -- 删除架构，但如果是 'dbo' 则不执行
    IF @SchemaName <> 'dbo'
    BEGIN
        DECLARE @DropSchemaStatement NVARCHAR(MAX)

        -- Build the DROP SCHEMA statement using parameterized query
        SET @DropSchemaStatement = N'DROP SCHEMA ' + QUOTENAME(@SchemaName)

        -- Execute the statement
        EXEC sp_executesql @DropSchemaStatement
    END


END;


-- 调用存储过程
EXEC ##DropSchemaAndObjects @SchemaName = 'metadataTesting';
EXEC ##DropSchemaAndObjects @SchemaName = 'metadataReporting';
EXEC ##DropSchemaAndObjects @SchemaName = 'metadataHelpers';
EXEC ##DropSchemaAndObjects @SchemaName = 'metadata';
EXEC ##DropSchemaAndObjects @SchemaName = 'dbo';
