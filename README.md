# Bug Tracking System

Java-based Bug Tracking System with JSP, Servlets, MySQL, and MVC architecture. Features user login/registration, bug reporting, dashboard stats, editing, and basic logout. User management and report export in progress.

## Features
- User Registration & Login
- Dashboard with Total Bugs, Open Bugs, Resolved Bugs, In-progress Bugs, and Recent Activities
- Report New Bugs and View/Edit Existing Bugs
- Export bug reports as CSV or PDF (feature in progress)
- User Logout

## Technologies Used
- Java (Servlets, JSP)
- MySQL database
- MVC design pattern
- NetBeans IDE

## Database Setup
1. Create a MySQL database (e.g., `bugtracker_db`).
2. Import the `bugtracker_schema.sql` file located in the `/database` folder:
   ```bash
   mysql -u yourusername -p bugtracker_db < bugtracker_schema.sql
3. Update database credentials in your DAO/config files.

## How to Run
1. Open the project in NetBeans.
2. Configure your local Apache Tomcat or any Java EE server.
3. Build and deploy the project.
4. Access the app at http://localhost:8080/yourprojectname/

## Future Enhancements
- Full user management and role-based access control
- Export reports fully implemented
- Improved UI/UX design
