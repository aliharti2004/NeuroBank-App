<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Erreur Serveur - 500</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .error-container {
                text-align: center;
                background-color: white;
                padding: 40px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                max-width: 500px;
            }

            .error-code {
                font-size: 72px;
                font-weight: bold;
                color: #c0392b;
                margin: 0;
            }

            .error-message {
                font-size: 24px;
                color: #333;
                margin: 20px 0;
            }

            .error-description {
                color: #666;
                margin-bottom: 30px;
            }

            .btn-home {
                display: inline-block;
                padding: 12px 24px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .btn-home:hover {
                background-color: #2980b9;
            }

            .error-details {
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 4px;
                padding: 15px;
                margin: 20px 0;
                font-family: monospace;
                font-size: 12px;
                text-align: left;
                max-height: 200px;
                overflow-y: auto;
            }
        </style>
    </head>

    <body>
        <div class="error-container">
            <h1 class="error-code">500</h1>
            <h2 class="error-message">Erreur Interne du Serveur</h2>
            <p class="error-description">
                Une erreur inattendue s'est produite lors du traitement de votre demande.
                <br>Nos équipes techniques ont été notifiées.
            </p>

            <% if (exception !=null && request.getAttribute("javax.servlet.error.exception") !=null) { %>
                <div class="error-details">
                    <strong>Détails techniques :</strong><br>
                    <%= exception.getClass().getName() %><br>
                        <%= exception.getMessage() !=null ? exception.getMessage() : "Aucun message" %>
                </div>
                <% } %>

                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-home">
                        Retour à l'accueil
                    </a>
        </div>
    </body>

    </html>