
drop table if exists hospital_project;
create table hospital_project(
Hospital_name varchar(100),
Hospital_location varchar(50),
Department varchar(50),
Doctor_count int,
Patients_count int,
Admission_date date,
Discharge_date date,
Medical_expense numeric(10,2)
); 
select * from hospital_project;
/*Total Number of Patients
Write an SQL query to find the total number of patients across all hospitals.*/
select hospital_name, sum(Patients_count) as total_patient
from hospital_project
group by hospital_name;


/*Average Number of Doctors per Hospital
Retrieve the average count of doctors available in each hospital.*/
select hospital_name, avg(doctor_count) as average_doctor
from hospital_project
group by hospital_name;


/*Top 3 Departments with the Highest Number of Patients
Find the top 3 hospital departments that have the highest number of patients.*/
select department , max (patients_count) as number_patients
from hospital_project
group by department
order by number_patients desc limit 3;


/*Hospital with the Maximum Medical Expenses
Identify the hospital that recorded the highest medical expenses.*/
select hospital_name , max(medical_expense) as maximum_expense
from hospital_project
group by hospital_name 
order by maximum_expense desc limit 1;


/*Daily Average Medical Expenses
Calculate the average medical expenses per day for each hospital.*/
select hospital_name, hospital_location,
avg(medical_expense/(discharge_date-admission_date)) as average_expense

from hospital_project
group by hospital_name, hospital_location
order by average_expense;

/*Longest Hospital Stay
Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.*/
select *,(discharge_date-admission_date)as stay_longest
from hospital_project
order by stay_longest desc limit 1;

/*Total Patients Treated Per City
Count the total number of patients treated in each city.*/
select hospital_location, hospital_name, sum(patients_count) as total_of_patients
from hospital_project
group by hospital_location, hospital_name
order by total_of_patients desc;

/*Average Length of Stay Per Department
Calculate the average number of days patients spend in each department.*/
select department,
avg(discharge_date-admission_date) as average_stay
from hospital_project
group by department
order by average_stay desc;

/*Identify the Department with the Lowest Number of Patients
Find the department with the least number of patients.*/
select department, min(patients_count) as lowest_number_of_patients
from hospital_project
group by department
order by lowest_number_of_patients;

/*Monthly Medical Expenses Report
Group the data by month and calculate the total medical expenses for each month.*/
select to_char(months.month,' yyyy-month') as month_name,
sum(medical_expense) as total_expense
from hospital_project h,
lateral generate_series(
date_trunc('month',h.admission_date ),
date_trunc('month',h.admission_date ),
interval'1 month'
) as months(month)
group by to_char(months.month,' yyyy-month')
order by month_name;




+