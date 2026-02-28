<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Connexion - NeuroBank</title>

        <!-- Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet">

        <style>
            :root {
                --bg-dark: #0a0e1a;
                --bg-card: #131827;
                --bg-input: #1a1f35;
                --accent-blue: #3b82f6;
                --accent-blue-dark: #2563eb;
                --accent-purple: #8b5cf6;
                --text-white: #ffffff;
                --text-gray: #94a3b8;
                --text-gray-light: #cbd5e1;
                --border-dark: #1e293b;
                --success: #10b981;
                --error: #ef4444;
            }

            *,
            *::before,
            *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            html,
            body {
                height: 100%;
                font-family: 'Inter', -apple-system, sans-serif;
                background: var(--bg-dark);
                color: var(--text-white);
            }

            /* Animated Background */
            .animated-bg {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 0;
                overflow: hidden;
            }

            .gradient-orb {
                position: absolute;
                border-radius: 50%;
                filter: blur(100px);
                opacity: 0.3;
                animation: float 20s ease-in-out infinite;
            }

            .orb-1 {
                width: 500px;
                height: 500px;
                background: var(--accent-blue);
                top: -250px;
                right: -250px;
            }

            .orb-2 {
                width: 400px;
                height: 400px;
                background: var(--accent-purple);
                bottom: -200px;
                left: -200px;
                animation-delay: 7s;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translate(0, 0) scale(1);
                }

                33% {
                    transform: translate(30px, -30px) scale(1.1);
                }

                66% {
                    transform: translate(-20px, 20px) scale(0.9);
                }
            }

            /* Container */
            .auth-container {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                position: relative;
                z-index: 1;
            }

            /* Back Button */
            .back-btn {
                position: absolute;
                top: 2rem;
                left: 2rem;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--text-gray);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                z-index: 10;
            }

            .back-btn:hover {
                color: var(--text-white);
                transform: translateX(-5px);
            }

            /* Auth Card */
            .auth-card {
                width: 100%;
                max-width: 450px;
                background: var(--bg-card);
                border: 1px solid var(--border-dark);
                border-radius: 1.5rem;
                padding: 3rem;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
                animation: slide-up 0.6s ease;
                position: relative;
                overflow: hidden;
            }

            .auth-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
            }

            @keyframes slide-up {
                from {
                    opac opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Logo */
            .auth-logo {
                text-align: center;
                margin-bottom: 2rem;
            }

            .logo-icon {
                width: 60px;
                height: 60px;
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                border-radius: 1rem;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                color: white;
                margin-bottom: 1rem;
                animation: pulse-icon 2s ease-in-out infinite;
            }

            @keyframes pulse-icon {

                0%,
                100% {
                    transform: scale(1);
                }

                50% {
                    transform: scale(1.05);
                }
            }

            .logo-text {
                font-size: 1.75rem;
                font-weight: 800;
                background: linear-gradient(135deg, var(--text-white), var(--text-gray-light));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .auth-subtitle {
                text-align: center;
                color: var(--text-gray);
                margin-top: 0.5rem;
                margin-bottom: 2rem;
            }

            /* Form */
            .auth-form {
                margin-bottom: 1.5rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: var(--text-gray-light);
                font-size: 0.95rem;
            }

            .form-input-wrapper {
                position: relative;
            }

            .form-input-icon {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-gray);
                transition: color 0.3s ease;
            }

            .form-input {
                width: 100%;
                padding: 0.875rem 1rem 0.875rem 3rem;
                background: var(--bg-input);
                border: 1px solid var(--border-dark);
                border-radius: 0.75rem;
                color: var(--text-white);
                font-size: 1rem;
                font-family: 'Inter', sans-serif;
                transition: all 0.3s ease;
            }

            .form-input:focus {
                outline: none;
                border-color: var(--accent-blue);
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            }

            .form-input:focus+.form-input-icon {
                color: var(--accent-blue);
            }

            .form-input::placeholder {
                color: var(--text-gray);
            }

            /* Alert Messages */
            .alert {
                padding: 1rem;
                border-radius: 0.75rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                font-size: 0.95rem;
                animation: slide-down 0.4s ease;
            }

            @keyframes slide-down {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .alert-success {
                background: rgba(16, 185, 129, 0.1);
                border: 1px solid rgba(16, 185, 129, 0.3);
                color: var(--success);
            }

            .alert-error {
                background: rgba(239, 68, 68, 0.1);
                border: 1px solid rgba(239, 68, 68, 0.3);
                color: var(--error);
            }

            /* Button */
            .btn {
                width: 100%;
                padding: 1rem;
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-blue-dark));
                color: white;
                border: none;
                border-radius: 0.75rem;
                font-size: 1rem;
                font-weight: 600;
                font-family: 'Inter', sans-serif;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                position: relative;
                overflow: hidden;
            }

            .btn::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.3);
                transform: translate(-50%, -50%);
                transition: width 0.6s, height 0.6s;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(59, 130, 246, 0.4);
            }

            .btn:hover::before {
                width: 300px;
                height: 300px;
            }

            .btn:active {
                transform: translateY(0);
            }

            /* Divider */
            .divider {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin: 2rem 0;
                color: var(--text-gray);
                font-size: 0.875rem;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border-dark);
            }

            /* Footer Link */
            .auth-footer {
                text-align: center;
                color: var(--text-gray);
                font-size: 0.95rem;
            }

            .auth-footer a {
                color: var(--accent-blue);
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .auth-footer a:hover {
                color: var(--accent-blue-dark);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .auth-card {
                    padding: 2rem;
                }

                .back-btn {
                    top: 1rem;
                    left: 1rem;
                }
            }
        </style>
    </head>

    <body>
        <!-- Animated Background -->
        <div class="animated-bg">
            <div class="gradient-orb orb-1"></div>
            <div class="gradient-orb orb-2"></div>
        </div>

        <!-- Back to Home -->
        <a href="${pageContext.request.contextPath}/" class="back-btn">
            <i class="fas fa-arrow-left"></i> Retour à l'accueil
        </a>

        <!-- Auth Container -->
        <div class="auth-container">
            <div class="auth-card">
                <!-- Logo -->
                <div class="auth-logo">
                    <div class="logo-icon">
                        <i class="fas fa-brain"></i>
                    </div>
                    <div class="logo-text">NeuroBank</div>
                </div>

                <p class="auth-subtitle">Bienvenue ! Connectez-vous à votre compte</p>

                <!-- Alerts -->
                <% if(request.getAttribute("success") !=null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>
                            <%= request.getAttribute("success") %>
                        </span>
                    </div>
                    <% } %>

                        <% if(request.getAttribute("error") !=null) { %>
                            <div class="alert alert-error">
                                <i class="fas fa-exclamation-circle"></i>
                                <span>
                                    <%= request.getAttribute("error") %>
                                </span>
                            </div>
                            <% } %>

                                <!-- Form -->
                                <form action="login" method="post" class="auth-form">
                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <div class="form-input-wrapper">
                                            <input type="text" name="login" class="form-input"
                                                placeholder="Entrez votre email" required autofocus>
                                            <i class="fas fa-envelope form-input-icon"></i>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Mot de passe</label>
                                        <div class="form-input-wrapper">
                                            <input type="password" name="password" class="form-input"
                                                placeholder="Entrez votre mot de passe" required>
                                            <i class="fas fa-lock form-input-icon"></i>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn">
                                        Se connecter à NeuroBank
                                    </button>
                                </form>

                                <!-- Footer -->
                                <div class="auth-footer">
                                    Nouveau sur NeuroBank ? <a
                                        href="${pageContext.request.contextPath}/inscription.jsp">Créer un compte</a>
                                </div>
            </div>
        </div>

        <script>
            // Add animation on form submit
            document.querySelector('.auth-form').addEventListener('submit', function (e) {
                const btn = this.querySelector('.btn');
                btn.style.opacity = '0.7';
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Connexion en cours...';
            });

            // Input focus animation
            document.querySelectorAll('.form-input').forEach(input => {
                input.addEventListener('focus', function () {
                    this.parentElement.parentElement.style.transform = 'scale(1.02)';
                    this.parentElement.parentElement.style.transition = 'transform 0.3s ease';
                });

                input.addEventListener('blur', function () {
                    this.parentElement.parentElement.style.transform = 'scale(1)';
                });
            });
        </script>
    </body>

    </html>