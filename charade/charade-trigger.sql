CREATE TRIGGER BeforeInsertMultipleChoice
ON multipleChoice
INSTEAD OF INSERT
AS
BEGIN

    DECLARE @v_charadeType CHAR(1);
	DECLARE @isCorrect INT;
    DECLARE @charadeID INT;

    DECLARE inserted_cursor CURSOR FOR
        SELECT charadeID FROM inserted;
    OPEN inserted_cursor;

    FETCH NEXT FROM inserted_cursor INTO @charadeID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        SELECT @v_charadeType = charadeType FROM charade WHERE charadeID = @charadeID;

       
        IF @v_charadeType <> 'm'
        BEGIN
            THROW 50000, 'Invalid entry: only multiple choice riddles can have multiple choice options', 1;
        END
	
	IF (SELECT COUNT(*) FROM inserted WHERE isCorrect = 1 AND charadeID = @charadeID ) > 1    
	BEGIN     
		RAISERROR ('Only one correct option is allowed per charade.', 16, 1);     
		ROLLBACK TRANSACTION;     
		RETURN;    
	END 
		
	SELECT charadeID FROM inserted WHERE isCorrect = 1;

	IF @isCorrect = 1 AND EXISTS (SELECT 1 FROM multipleChoice WHERE charadeID = @charadeID AND isCorrect = 1)
	BEGIN
		RAISERROR ("There's already a correct option for this charade.", 16, 1);
		ROLLBACK TRANSACTION;
		RETURN;
	END;

        FETCH NEXT FROM inserted_cursor INTO @charadeID;
    END

    CLOSE inserted_cursor;
    DEALLOCATE inserted_cursor;

    INSERT INTO multipleChoice (multipleChoiceID, charadeID, optionText, isCorrect)
        SELECT multipleChoiceID, charadeID, optionText, isCorrect FROM inserted;
END
