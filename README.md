# NeuroBank (BankLoanProject)

## Short Description
NeuroBank is a comprehensive web-based platform designed to manage and analyze bank loan applications. It integrates a Java-based enterprise backend with a Machine Learning Artificial Intelligence engine (Python/Flask) to automate loan risk assessment, providing bank agents with AI-driven recommendations based on an applicant's profile and loan parameters.

## Features
*   **Multi-Role Dashboards**: Distinct interfaces and permissions for Clients, Agents, and Administrators.
*   **Loan Application Management**: Clients can apply for loans, specifying amount, duration, interest rate, and type.
*   **AI-Driven Risk Analysis**: Real-time evaluation of loan applications using a Logistic Regression machine learning model to predict the probability of default and compute a risk score.
*   **Decision Support System**: Automatically provides actionable advice (e.g., "RISQUE FAIBLE - Validation recommandée") to assist bank agents in approving or rejecting loans.
*   **Resilience & Error Handling**: Graceful degradation allows manual processing of loans even if the AI microservice is temporarily unavailable.

## Tech Stack
**Core Backend (Java Application):**
*   **Language**: Java 17
*   **Frameworks/APIs**: Java Servlets & JSP (Jakarta EE)
*   **Build Tool**: Maven
*   **Database**: PostgreSQL
*   **Data Processing**: Jackson (`jackson-databind`), `org.json`
*   **Architecture**: MVC (Model-View-Controller) with DAO and Service layers

**Artificial Intelligence Service (Python API):**
*   **Language**: Python 3.x
*   **Web Framework**: Flask, Flask-CORS
*   **Machine Learning**: `scikit-learn` (Logistic Regression), `pandas`, `numpy`, `joblib`

## Folder Structure
```text
NeuroBank/
├── src/
│   └── main/
│       └── java/
│           └── com/banque/
│               ├── controller/   # Java Servlets for handling HTTP requests
│               ├── dao/          # Data Access Objects for database operations
│               ├── model/        # Data models (Client, DemandePret, PredictionIA)
│               ├── service/      # Business logic & AI API integration
│               └── utils/        # Utility classes (DB connection)
├── flask_api/
│   ├── app.py                    # Flask server exposing the /predict endpoint
│   ├── models/                   # Serialized ML models & scalers (.joblib)
│   └── venv/                     # Python virtual environment
├── pom.xml                       # Maven configuration and dependencies
└── README.md
```

## Installation

### Prerequisites
*   Java Development Kit (JDK) 17
*   Apache Maven
*   Apache Tomcat (or any compatible Servlet Container)
*   PostgreSQL
*   Python 3.8+

### Database Setup
1.  Ensure PostgreSQL is running.
2.  Create a database for the project.
3.  Update the database connection credentials in `src/main/java/com/banque/utils/DBConnection.java` to match your local setup.

### Python AI API Setup
1.  Navigate to the AI service directory:
    ```bash
    cd flask_api
    ```
2.  (Optional but recommended) Create and activate a virtual environment:
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows: venv\Scripts\activate
    ```
3.  Install the required Python packages (e.g., `flask`, `flask-cors`, `scikit-learn`, `pandas`, `numpy`, `joblib`).
    ```bash
    pip install flask flask-cors scikit-learn pandas numpy joblib
    ```

## How to Run

1.  **Start the AI Service:**
    Open a terminal, navigate to `flask_api`, activate the virtual environment, and run the Flask app:
    ```bash
    cd flask_api
    python app.py
    ```
    The AI service will start on `http://localhost:5000`.

2.  **Deploy the Java Web Application:**
    Open another terminal at the project root (`NeuroBank/`) and build the `.war` package using Maven:
    ```bash
    mvn clean package
    ```
    Deploy the generated `target/BankLoanProject.war` to your Tomcat `webapps` directory and start the Tomcat server.

3.  **Access the Application:**
    Open your web browser and navigate to the application URL (usually `http://localhost:8080/BankLoanProject`).

## Author
*Created and maintained by the NeuroBank Development Team.*
