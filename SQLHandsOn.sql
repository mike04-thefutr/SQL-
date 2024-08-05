SELECT *
FROM [master].[dbo].[application_record$]

SELECT CODE_GENDER 
,  CASE WHEN CODE_GENDER = 'F' THEN 'Female'
        WHEN CODE_GENDER = 'M' THEN 'Male'
		ELSE CODE_GENDER 
		END 
	FROM [master].[dbo].[application_record$]


