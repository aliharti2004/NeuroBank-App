<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Profil - NeuroBank</title>

            <!-- Icons -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

            <!-- Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">

            <!-- Reuse the same CSS from dashboard.jsp -->
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
                    --warning: #f59e0b;
                    --error: #ef4444;
                    --sidebar-width: 260px;
                }

                *,
                *::before,
                *::after {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                body {
                    font-family: 'Inter', -apple-system, sans-serif;
                    background: var(--bg-dark);
                    color: var(--text-white);
                    line-height: 1.6;
                }

                .app-layout {
                    display: flex;
                    min-height: 100vh;
                }

                /* Sidebar - Same as dashboard */
                .sidebar {
                    width: var(--sidebar-width);
                    background: var(--bg-card);
                    border-right: 1px solid var(--border-dark);
                    display: flex;
                    flex-direction: column;
                    position: fixed;
                    height: 100vh;
                    left: 0;
                    top: 0;
                }

                .sidebar-header {
                    padding: 2rem 1.5rem;
                    border-bottom: 1px solid var(--border-dark);
                }

                .logo {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                }

                .logo-icon {
                    width: 40px;
                    height: 40px;
                    background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                    border-radius: 0.75rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.25rem;
                    color: white;
                }

                .logo-text {
                    font-size: 1.25rem;
                    font-weight: 800;
                    background: linear-gradient(135deg, var(--text-white), var(--text-gray-light));
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                .sidebar-nav {
                    flex: 1;
                    padding: 1.5rem 1rem;
                    display: flex;
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .nav-item {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    padding: 0.875rem 1rem;
                    color: var(--text-gray);
                    text-decoration: none;
                    border-radius: 0.75rem;
                    transition: all 0.3s ease;
                    font-weight: 500;
                }

                .nav-item:hover {
                    background: var(--bg-input);
                    color: var(--text-white);
                }

                .nav-item.active {
                    background: rgba(59, 130, 246, 0.1);
                    color: var(--accent-blue);
                }

                .nav-item i {
                    font-size: 1.125rem;
                }

                .nav-item.logout {
                    margin-top: auto;
                    color: var(--error);
                }

                .nav-item.logout:hover {
                    background: rgba(239, 68, 68, 0.1);
                }

                /* Main Content */
                .main-content {
                    margin-left: var(--sidebar-width);
                    flex: 1;
                    padding: 2rem;
                    max-width: calc(100% - var(--sidebar-width));
                }

                /* Page Header */
                .page-header {
                    margin-bottom: 2rem;
                }

                .page-title {
                    font-size: 2rem;
                    font-weight: 800;
                    margin-bottom: 0.5rem;
                }

                .page-subtitle {
                    color: var(--text-gray);
                    font-size: 1rem;
                }

                /* Alert */
                .alert {
                    padding: 1.25rem 1.5rem;
                    border-radius: 0.75rem;
                    margin-bottom: 2rem;
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    animation: slide-in 0.4s ease;
                }

                @keyframes slide-in {
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

                .alert-danger {
                    background: rgba(239, 68, 68, 0.1);
                    border: 1px solid rgba(239, 68, 68, 0.3);
                    color: var(--error);
                }

                /* Card */
                .card {
                    background: var(--bg-card);
                    border: 1px solid var(--border-dark);
                    border-radius: 1rem;
                    overflow: hidden;
                    margin-bottom: 2rem;
                }

                .card-header {
                    padding: 1.5rem;
                    border-bottom: 1px solid var(--border-dark);
                }

                .card-title {
                    font-size: 1.25rem;
                    font-weight: 700;
                }

                .card-body {
                    padding: 2rem;
                }

                /* Form */
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

                .form-input {
                    width: 100%;
                    padding: 0.875rem 1rem;
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

                .form-input::placeholder {
                    color: var(--text-gray);
                }

                .form-help {
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    color: var(--text-gray);
                    font-size: 0.875rem;
                    margin-top: 0.5rem;
                }

                .form-help i {
                    color: var(--accent-blue);
                }

                /* Buttons */
                .btn-group {
                    display: flex;
                    gap: 1rem;
                    margin-top: 2rem;
                }

                .btn {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.75rem;
                    padding: 0.875rem 1.75rem;
                    color: white;
                    text-decoration: none;
                    border-radius: 0.75rem;
                    font-weight: 600;
                    font-size: 1rem;
                    transition: all 0.3s ease;
                    border: none;
                    cursor: pointer;
                    font-family: 'Inter', sans-serif;
                }

                .btn-primary {
                    background: linear-gradient(135deg, var(--accent-blue), var(--accent-blue-dark));
                    box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
                }

                .btn-secondary {
                    background: var(--bg-input);
                    color: var(--text-gray-light);
                    border: 1px solid var(--border-dark);
                    box-shadow: none;
                }

                .btn-secondary:hover {
                    background: var(--bg-card);
                    color: var(--text-white);
                    border-color: var(--accent-blue);
                }

                /* Info Card */
                .info-card {
                    background: rgba(59, 130, 246, 0.05);
                    border: 1px solid rgba(59, 130, 246, 0.2);
                }

                .info-card-icon {
                    font-size: 1.5rem;
                    margin-bottom: 0.75rem;
                }

                .info-card-title {
                    font-size: 1.1rem;
                    font-weight: 600;
                    margin-bottom: 0.5rem;
                }

                .info-card-text {
                    color: var(--text-gray);
                    font-size: 0.95rem;
                    line-height: 1.6;
                }

                /* Responsive */
                @media (max-width: 768px) {
                    .sidebar {
                        width: 80px;
                    }

                    .sidebar-header {
                        padding: 1.5rem 1rem;
                    }

                    .logo-text,
                    .nav-item span {
                        display: none;
                    }

                    .main-content {
                        margin-left: 80px;
                        max-width: calc(100% - 80px);
                    }
                }
            </style>
        </head>

        <body>
            <div class="app-layout">
                <!-- Sidebar -->
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <div class="logo">
                            <div class="logo-icon">
                                <i class="fas fa-brain"></i>
                            </div>
                            <div class="logo-text">NeuroBank</div>
                        </div>
                    </div>

                    <nav class="sidebar-nav">
                        <a href="<%= request.getContextPath() %>/client/dashboard" class="nav-item">
                            <i class="fas fa-home"></i>
                            <span>Tableau de bord</span>
                        </a>
                        <a href="<%= request.getContextPath() %>/client/nouveau_pret" class="nav-item">
                            <i class="fas fa-plus-circle"></i>
                            <span>Nouvelle demande</span>
                        </a>
                        <a href="<%= request.getContextPath() %>/client/profil" class="nav-item active">
                            <i class="fas fa-user"></i>
                            <span>Profil</span>
                        </a>
                        <a href="<%= request.getContextPath() %>/logout" class="nav-item logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Déconnexion</span>
                        </a>
                    </nav>
                </aside>

                <!-- Main Content -->
                <main class="main-content">
                    <!-- Page Header -->
                    <div class="page-header">
                        <h1 class="page-title">Profil financier</h1>
                        <p class="page-subtitle">Informations requises pour l'analyse de votre demande de prêt</p>
                    </div>

                    <!-- Success Alert -->
                    <c:if test="${not empty sessionScope.successMsg}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle" style="font-size: 1.5rem;"></i>
                            <span>${sessionScope.successMsg}</span>
                        </div>
                        <c:remove var="successMsg" scope="session" />
                    </c:if>

                    <!-- Error Alert -->
                    <c:if test="${not empty sessionScope.errorMsg}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle" style="font-size: 1.5rem;"></i>
                            <span>${sessionScope.errorMsg}</span>
                        </div>
                        <c:remove var="errorMsg" scope="session" />
                    </c:if>

                    <!-- Profile Form -->
                    <div style="max-width: 700px;">
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Financial Information</h2>
                            </div>
                            <div class="card-body">
                                <form method="post" action="<%= request.getContextPath() %>/client/profil">
                                    <!-- City -->
                                    <div class="form-group">
                                        <label for="ville" class="form-label">Ville *</label>
                                        <input type="text" id="ville" name="ville" class="form-input"
                                            placeholder="e.g., Casablanca" value="${client != null ? client.ville : ''}"
                                            required>
                                    </div>

                                    <!-- Postal Code -->
                                    <div class="form-group">
                                        <label for="cp" class="form-label">Code postal *</label>
                                        <input type="text" id="cp" name="cp" class="form-input"
                                            placeholder="e.g., 20000" value="${client != null ? client.codePostal : ''}"
                                            pattern="[0-9]{5}" title="Postal code must contain 5 digits" required>
                                    </div>

                                    <!-- Monthly Income -->
                                    <div class="form-group">
                                        <label for="revenu" class="form-label">Revenu mensuel (€) *</label>
                                        <input type="number" id="revenu" name="revenu" class="form-input"
                                            placeholder="e.g., 5000"
                                            value="${client != null ? client.revenuMensuel : ''}" min="1" step="0.01"
                                            required>
                                        <div class="form-help">
                                            <i class="fas fa-info-circle"></i>
                                            <span>Your net monthly income is used to calculate your debt capacity (40%
                                                rule).</span>
                                        </div>
                                    </div>

                                    <!-- Buttons -->
                                    <div class="btn-group">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i>
                                            Enregistrer le profil
                                        </button>
                                        <a href="<%= request.getContextPath() %>/client/dashboard"
                                            class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i>
                                            Retour au tableau de bord
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Privacy Info Card -->
                        <div class="card info-card">
                            <div class="card-body">
                                <div class="info-card-icon">
                                    <i class="fas fa-shield-alt" style="color: var(--accent-blue);"></i>
                                </div>
                                <h3 class="info-card-title">Confidentialité et sécurité</h3>
                                <p class="info-card-text">
                                    Your financial data is strictly confidential and used only for analyzing your loan
                                    applications.
                                    It will never be shared with third parties. All data is encrypted and securely
                                    stored.
                                </p>
                            </div>
                        </div>
                    </div>
                </main>
            </div>

            <script>
                // Add animation to form inputs
                document.querySelectorAll('.form-input').forEach(input => {
                    input.addEventListener('focus', function () {
                        this.parentElement.style.transform = 'scale(1.01)';
                        this.parentElement.style.transition = 'transform 0.3s ease';
                    });

                    input.addEventListener('blur', function () {
                        this.parentElement.style.transform = 'scale(1)';
                    });
                });
            </script>
        </body>

        </html>