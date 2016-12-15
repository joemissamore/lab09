use missamore;

# Write a query that returns the company_id, company name, the number of resumes submitted
# to that company, and the average gpa of the resumes the submitted, and the number of people
# that were hired.

# Save the query as a VIEW as company_resume_statistics.
create or replace view company_resume_statistics as 
select c.company_id, c.company_name, COUNT(resume_id), avg_company_gpa(company_name)
from resume_company rc
join company c ON rc.company_id=c.company_id
GROUP BY c.company_id;


#3 Create a stored procedure that uses the VIEW, takes in a company id as it’s only input and
#  returns the information for the given company.
DROP PROCEDURE IF EXISTS company_id_statisics;

DELIMITER //
	CREATE PROCEDURE company_id_statistics (_company_id varchar(255))
		BEGIN
			SELECT * FROM company_resume_statistics where company_id = _company_id;
        END //
DELIMITER ;

	# CALLS THE PROCEDURE
	CALL company_id_statistics(1);
    
    
#Create a stored procedure that uses the VIEW and returns companies who have an average gpa
#greater than or equal to the input value. 

DROP PROCEDURE IF EXISTS company_avg_gpa;

DELIMITER //
	CREATE PROCEDURE company_avg_gpa (_avg_gpa int)
		BEGIN
			SELECT * FROM company_resume_statistics where avg_company_gpa(company_name) >= _avg_gpa;
		END //
DELIMITER ;

#CALLS THE FUNCTION
call company_avg_gpa(3);