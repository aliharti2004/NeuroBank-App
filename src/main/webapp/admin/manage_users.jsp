<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <fmt:setLocale value="fr_FR" />
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Gestion Utilisateurs - NeuroBank Admin</title>

                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">

                <style>
                    :root {
                        --bg-dark: #0a0e1a;
                        --bg-card: #131827;
                        --bg-hover: #1a2234;
                        --text-white: #ffffff;
                        --text-gray: #94a3b8;
                        --text-gray-light: #cbd5e1;
                        --accent-blue: #3b82f6;
                        --accent-blue-dark: #2563eb;
                        --accent-purple: #8b5cf6;
                        --success: #10b981;
                        --warning: #f59e0b;
                        --error: #ef4444;
                        --border-dark: #1e293b;
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

                    .dashboard-container {
                        display: flex;
                        min-height: 100vh;
                    }

                    .sidebar {
                        width: 280px;
                        background: rgba(19, 24, 39, 0.7);
                        backdrop-filter: blur(20px);
                        border-right: 1px solid var(--border-dark);
                        padding: 2rem 1.5rem;
                        position: fixed;
                        height: 100vh;
                        overflow-y: auto;
                    }

                    .logo {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                        margin-bottom: 2rem;
                        padding-bottom: 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                    }

                    .logo-icon {
                        width: 45px;
                        height: 45px;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        border-radius: 0.75rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.35rem;
                        color: white;
                    }

                    .logo-text {
                        font-size: 1.35rem;
                        font-weight: 800;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .nav-links {
                        display: flex;
                        flex-direction: column;
                        gap: 0.5rem;
                    }

                    .nav-item {
                        display: flex;
                        align-items: center;
                        gap: 0.875rem;
                        padding: 1rem 1.25rem;
                        color: var(--text-gray);
                        text-decoration: none;
                        border-radius: 0.75rem;
                        transition: all 0.3s ease;
                        font-weight: 500;
                    }

                    .nav-item:hover,
                    .nav-item.active {
                        background: rgba(59, 130, 246, 0.1);
                        color: var(--accent-blue);
                    }

                    .nav-item.active {
                        border-left: 3px solid var(--accent-blue);
                    }

                    .nav-item.logout {
                        margin-top: 2rem;
                        color: var(--error);
                        border-top: 1px solid var(--border-dark);
                        padding-top: 1.5rem;
                    }

                    .main-content {
                        margin-left: 280px;
                        flex: 1;
                        padding: 2rem;
                    }

                    .page-header {
                        margin-bottom: 2.5rem;
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                    }

                    .page-title {
                        font-size: 2rem;
                        font-weight: 800;
                        margin-bottom: 0.5rem;
                    }

                    .btn {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.75rem;
                        padding: 0.875rem 1.75rem;
                        color: white;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-blue-dark));
                        text-decoration: none;
                        border-radius: 0.75rem;
                        font-weight: 600;
                        transition: all 0.3s ease;
                        border: none;
                        cursor: pointer;
                        font-family: inherit;
                        font-size: 1rem;
                    }

                    .btn:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
                    }

                    .alert {
                        padding: 1.25rem 1.5rem;
                        border-radius: 0.75rem;
                        margin-bottom: 2rem;
                        display: flex;
                        align-items: center;
                        gap: 1rem;
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

                    .controls {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 1.5rem;
                        margin-bottom: 1.5rem;
                    }

                    .filters-row {
                        display: grid;
                        grid-template-columns: 2fr 1fr 1fr 1fr;
                        gap: 1rem;
                        margin-bottom: 1rem;
                    }

                    .filter-label {
                        display: block;
                        margin-bottom: 0.5rem;
                        font-size: 0.875rem;
                        font-weight: 600;
                        color: var(--text-gray-light);
                    }

                    .search-box,
                    .filter-select {
                        width: 100%;
                        padding: 0.75rem 1rem;
                        background: var(--bg-hover);
                        border: 1px solid var(--border-dark);
                        border-radius: 0.75rem;
                        color: var(--text-white);
                        font-family: inherit;
                        font-size: 0.95rem;
                    }

                    .search-box:focus,
                    .filter-select:focus {
                        outline: none;
                        border-color: var(--accent-blue);
                    }

                    .results-info {
                        display: flex;
                        justify-content: space-between;
                        color: var(--text-gray);
                        font-size: 0.9rem;
                    }

                    .card {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        overflow: hidden;
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    thead {
                        background: rgba(255, 255, 255, 0.03);
                    }

                    th {
                        padding: 1.25rem 1.5rem;
                        text-align: left;
                        font-weight: 700;
                        font-size: 0.875rem;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        color: var(--text-gray-light);
                    }

                    td {
                        padding: 1.25rem 1.5rem;
                        border-top: 1px solid var(--border-dark);
                    }

                    tr:hover {
                        background: rgba(255, 255, 255, 0.02);
                    }

                    .role-badge {
                        display: inline-block;
                        padding: 0.375rem 0.875rem;
                        border-radius: 0.5rem;
                        font-size: 0.8rem;
                        font-weight: 700;
                        text-transform: uppercase;
                    }

                    .role-admin {
                        background: rgba(245, 158, 11, 0.15);
                        color: var(--warning);
                    }

                    .role-agent {
                        background: rgba(59, 130, 246, 0.15);
                        color: var(--accent-blue);
                    }

                    .role-client {
                        background: rgba(139, 92, 246, 0.15);
                        color: var(--accent-purple);
                    }

                    .action-btn {
                        padding: 0.5rem 1rem;
                        border-radius: 0.5rem;
                        border: none;
                        cursor: pointer;
                        font-weight: 500;
                        font-size: 0.875rem;
                        transition: all 0.2s;
                        margin-right: 0.5rem;
                    }

                    .btn-edit {
                        background: rgba(59, 130, 246, 0.15);
                        color: var(--accent-blue);
                    }

                    .btn-edit:hover {
                        background: rgba(59, 130, 246, 0.25);
                    }

                    .btn-delete {
                        background: rgba(239, 68, 68, 0.15);
                        color: var(--error);
                    }

                    .btn-delete:hover {
                        background: rgba(239, 68, 68, 0.25);
                    }

                    .pagination {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 1.5rem;
                        background: var(--bg-card);
                        border: 1px solid var(--border-dark);
                        border-radius: 1rem;
                        margin-top: 1.5rem;
                    }

                    .pagination-info {
                        color: var(--text-gray);
                        font-size: 0.9rem;
                    }

                    .pagination-controls {
                        display: flex;
                        gap: 0.5rem;
                    }

                    .page-btn {
                        padding: 0.5rem 0.875rem;
                        border-radius: 0.5rem;
                        border: 1px solid var(--border-dark);
                        background: var(--bg-hover);
                        color: var(--text-white);
                        cursor: pointer;
                        transition: all 0.2s;
                        text-decoration: none;
                        font-size: 0.875rem;
                    }

                    .page-btn:hover:not(.disabled) {
                        background: rgba(59, 130, 246, 0.15);
                        border-color: var(--accent-blue);
                        color: var(--accent-blue);
                    }

                    .page-btn.active {
                        background: var(--accent-blue);
                        border-color: var(--accent-blue);
                        color: white;
                    }

                    .page-btn.disabled {
                        opacity: 0.4;
                        cursor: not-allowed;
                    }

                    .modal {
                        display: none;
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(0, 0, 0, 0.7);
                        backdrop-filter: blur(5px);
                        z-index: 1000;
                        justify-content: center;
                        align-items: center;
                    }

                    .modal.active {
                        display: flex;
                    }

                    .modal-content {
                        background: var(--bg-card);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        width: 90%;
                        max-width: 600px;
                        max-height: 90vh;
                        overflow-y: auto;
                        padding: 2rem;
                        position: relative;
                    }

                    .modal-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 2rem;
                    }

                    .modal-title {
                        font-size: 1.5rem;
                        font-weight: 700;
                    }

                    .close-btn {
                        background: none;
                        border: none;
                        color: var(--text-gray);
                        font-size: 1.5rem;
                        cursor: pointer;
                        padding: 0;
                        width: 35px;
                        height: 35px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 0.5rem;
                        transition: all 0.2s;
                    }

                    .close-btn:hover {
                        background: var(--bg-hover);
                        color: var(--text-white);
                    }

                    .form-group {
                        margin-bottom: 1.5rem;
                    }

                    .form-label {
                        display: block;
                        margin-bottom: 0.5rem;
                        font-weight: 600;
                        color: var(--text-gray-light);
                    }

                    .form-input,
                    .form-select {
                        width: 100%;
                        padding: 0.875rem 1.25rem;
                        background: var(--bg-hover);
                        border: 1px solid var(--border-dark);
                        border-radius: 0.75rem;
                        color: var(--text-white);
                        font-family: inherit;
                        font-size: 1rem;
                    }

                    .form-input:focus,
                    .form-select:focus {
                        outline: none;
                        border-color: var(--accent-blue);
                        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
                    }

                    .form-actions {
                        display: flex;
                        gap: 1rem;
                        justify-content: flex-end;
                        margin-top: 2rem;
                    }

                    .btn-secondary {
                        background: var(--bg-hover);
                        color: var(--text-white);
                    }

                    .btn-secondary:hover {
                        background: var(--border-dark);
                    }
                </style>
            </head>

            <body>
                <div class="dashboard-container">
                    <aside class="sidebar">
                        <div class="logo">
                            <div class="logo-icon"><i class="fas fa-university"></i></div>
                            <div class="logo-text">NeuroBank</div>
                        </div>

                        <div
                            style="background: rgba(245, 158, 11, 0.1); border: 1px solid rgba(245, 158, 11, 0.3); border-radius: 0.75rem; padding: 0.875rem 1.25rem; margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between;">
                            <span
                                style="color: var(--text-gray-light); font-size: 0.85rem; font-weight: 500;">Rôle</span>
                            <span
                                style="background: rgba(245, 158, 11, 0.2); color: var(--warning); padding: 0.375rem 0.875rem; border-radius: 0.5rem; font-weight: 700; font-size: 0.875rem;">ADMIN</span>
                        </div>

                        <nav class="nav-links">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                                <i class="fas fa-chart-pie"></i> Tableau de bord
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users" class="nav-item active">
                                <i class="fas fa-users"></i> Utilisateurs
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/settings" class="nav-item">
                                <i class="fas fa-cog"></i> Paramètres
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                                <i class="fas fa-sign-out-alt"></i> Déconnexion
                            </a>
                        </nav>
                    </aside>

                    <main class="main-content">
                        <div class="page-header">
                            <div>
                                <h1 class="page-title">Gestion des Utilisateurs</h1>
                                <p style="color: var(--text-gray);">Gérer tous les utilisateurs du système</p>
                            </div>
                            <button class="btn" onclick="openCreateModal()">
                                <i class="fas fa-plus"></i> Nouvel Utilisateur
                            </button>
                        </div>

                        <c:if test="${not empty sessionScope.successMsg}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle" style="font-size: 1.5rem;"></i>
                                <span>${sessionScope.successMsg}</span>
                            </div>
                            <c:remove var="successMsg" scope="session" />
                        </c:if>

                        <c:if test="${not empty sessionScope.errorMsg}">
                            <div class="alert alert-error">
                                <i class="fas fa-exclamation-circle" style="font-size: 1.5rem;"></i>
                                <span>${sessionScope.errorMsg}</span>
                            </div>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>

                        <div class="controls">
                            <form method="get" id="filterForm">
                                <div class="filters-row">
                                    <div>
                                        <label class="filter-label"><i class="fas fa-search"></i> Recherche</label>
                                        <input type="text" name="search" class="search-box"
                                            placeholder="Rechercher par nom, prénom ou email..." value="${searchTerm}">
                                    </div>
                                    <div>
                                        <label class="filter-label"><i class="fas fa-user-tag"></i> Rôle</label>
                                        <select name="role" class="filter-select" onchange="this.form.submit()">
                                            <option value="ALL" ${roleFilter==null || roleFilter=='ALL' ? 'selected'
                                                : '' }>Tous les rôles</option>
                                            <option value="CLIENT" ${roleFilter=='CLIENT' ? 'selected' : '' }>Clients
                                            </option>
                                            <option value="AGENT" ${roleFilter=='AGENT' ? 'selected' : '' }>Agents
                                            </option>
                                            <option value="ADMIN" ${roleFilter=='ADMIN' ? 'selected' : '' }>Admins
                                            </option>
                                        </select>
                                    </div>
                                    <div>
                                        <label class="filter-label"><i class="fas fa-toggle-on"></i> Statut</label>
                                        <select name="status" class="filter-select" onchange="this.form.submit()">
                                            <option value="ALL" ${statusFilter==null || statusFilter=='ALL' ? 'selected'
                                                : '' }>Tous</option>
                                            <option value="ACTIVE" ${statusFilter=='ACTIVE' ? 'selected' : '' }>Actifs
                                            </option>
                                            <option value="INACTIVE" ${statusFilter=='INACTIVE' ? 'selected' : '' }>
                                                Inactifs</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label class="filter-label"><i class="fas fa-sort"></i> Trier par</label>
                                        <select name="sortBy" class="filter-select" onchange="this.form.submit()">
                                            <option value="date" ${sortBy==null || sortBy=='date' ? 'selected' : '' }>
                                                Plus récent</option>
                                            <option value="name" ${sortBy=='name' ? 'selected' : '' }>Nom</option>
                                            <option value="email" ${sortBy=='email' ? 'selected' : '' }>Email</option>
                                            <option value="role" ${sortBy=='role' ? 'selected' : '' }>Rôle</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="results-info">
                                    <span><i class="fas fa-users"></i> ${totalUsers} utilisateur(s) trouvé(s)</span>
                                    <span>Page ${currentPage} sur ${totalPages}</span>
                                </div>
                            </form>
                        </div>

                        <div class="card">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nom & Email</th>
                                        <th>Rôle</th>
                                        <th>Statut</th>
                                        <th>Date de création</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td>#${user.idUser}</td>
                                            <td>
                                                <div style="font-weight: 600;">${user.prenom} ${user.nom}</div>
                                                <div style="color: var(--text-gray); font-size: 0.875rem;">${user.login}
                                                </div>
                                            </td>
                                            <td>
                                                <span
                                                    class="role-badge role-${user.role.toLowerCase()}">${user.role}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.actif}">
                                                        <span style="color: var(--success);"><i class="fas fa-circle"
                                                                style="font-size: 0.5rem;"></i> Actif</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: var(--error);"><i class="fas fa-circle"
                                                                style="font-size: 0.5rem;"></i> Inactif</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${user.dateCreation}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td>
                                                <button class="action-btn btn-edit"
                                                    onclick="openEditModal(${user.idUser}, '${user.login}', '${user.nom}', '${user.prenom}', '${user.role}', ${user.actif})">
                                                    <i class="fas fa-edit"></i> Modifier
                                                </button>
                                                <button class="action-btn btn-delete"
                                                    onclick="confirmDelete(${user.idUser}, '${user.prenom} ${user.nom}')">
                                                    <i class="fas fa-trash"></i> Supprimer
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <c:if test="${totalPages > 1}">
                            <div class="pagination">
                                <div class="pagination-info">
                                    Affichage de ${(currentPage - 1) * itemsPerPage + 1} à ${currentPage * itemsPerPage
                                    > totalUsers ? totalUsers : currentPage * itemsPerPage} sur ${totalUsers}
                                    utilisateurs
                                </div>
                                <div class="pagination-controls">
                                    <a href="?page=${currentPage - 1}&search=${searchTerm}&role=${roleFilter}&status=${statusFilter}&sortBy=${sortBy}"
                                        class="page-btn ${currentPage == 1 ? 'disabled' : ''}">
                                        <i class="fas fa-chevron-left"></i> Précédent
                                    </a>

                                    <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                        <c:if
                                            test="${pageNum <= 3 || pageNum > totalPages - 3 || (pageNum >= currentPage - 1 && pageNum <= currentPage + 1)}">
                                            <a href="?page=${pageNum}&search=${searchTerm}&role=${roleFilter}&status=${statusFilter}&sortBy=${sortBy}"
                                                class="page-btn ${currentPage == pageNum ? 'active' : ''}">
                                                ${pageNum}
                                            </a>
                                        </c:if>
                                        <c:if test="${pageNum == 4 && currentPage > 5}">
                                            <span class="page-btn disabled">...</span>
                                        </c:if>
                                        <c:if test="${pageNum == totalPages - 3 && currentPage < totalPages - 4}">
                                            <span class="page-btn disabled">...</span>
                                        </c:if>
                                    </c:forEach>

                                    <a href="?page=${currentPage + 1}&search=${searchTerm}&role=${roleFilter}&status=${statusFilter}&sortBy=${sortBy}"
                                        class="page-btn ${currentPage >= totalPages ? 'disabled' : ''}">
                                        Suivant <i class="fas fa-chevron-right"></i>
                                    </a>
                                </div>
                            </div>
                        </c:if>
                    </main>
                </div>

                <!-- Create User Modal -->
                <div id="createModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2 class="modal-title">Créer un Utilisateur</h2>
                            <button class="close-btn" onclick="closeModal('createModal')"><i
                                    class="fas fa-times"></i></button>
                        </div>
                        <form method="post" action="${pageContext.request.contextPath}/admin/users">
                            <input type="hidden" name="action" value="create">

                            <div class="form-group">
                                <label class="form-label">Email (Login) *</label>
                                <input type="email" name="login" class="form-input" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Mot de passe *</label>
                                <input type="password" name="password" class="form-input" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Prénom *</label>
                                <input type="text" name="prenom" class="form-input" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Nom *</label>
                                <input type="text" name="nom" class="form-input" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Rôle *</label>
                                <select name="role" class="form-select" required>
                                    <option value="CLIENT">Client</option>
                                    <option value="AGENT">Agent</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Statut</label>
                                <select name="actif" class="form-select">
                                    <option value="true">Actif</option>
                                    <option value="false">Inactif</option>
                                </select>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="btn btn-secondary"
                                    onclick="closeModal('createModal')">Annuler</button>
                                <button type="submit" class="btn"><i class="fas fa-save"></i> Créer</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Edit User Modal -->
                <div id="editModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2 class="modal-title">Modifier l'Utilisateur</h2>
                            <button class="close-btn" onclick="closeModal('editModal')"><i
                                    class="fas fa-times"></i></button>
                        </div>
                        <form method="post" action="${pageContext.request.contextPath}/admin/users">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="userId" id="editUserId">

                            <div class="form-group">
                                <label class="form-label">Email (Login) *</label>
                                <input type="email" name="login" id="editLogin" class="form-input" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Prénom *</label>
                                <input type="text" name="prenom" id="editPrenom" class="form-input" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Nom *</label>
                                <input type="text" name="nom" id="editNom" class="form-input" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Rôle *</label>
                                <select name="role" id="editRole" class="form-select" required>
                                    <option value="CLIENT">Client</option>
                                    <option value="AGENT">Agent</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Statut</label>
                                <select name="actif" id="editActif" class="form-select">
                                    <option value="true">Actif</option>
                                    <option value="false">Inactif</option>
                                </select>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="btn btn-secondary"
                                    onclick="closeModal('editModal')">Annuler</button>
                                <button type="submit" class="btn"><i class="fas fa-save"></i> Enregistrer</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    function openCreateModal() {
                        document.getElementById('createModal').classList.add('active');
                    }

                    function openEditModal(userId, login, nom, prenom, role, actif) {
                        document.getElementById('editUserId').value = userId;
                        document.getElementById('editLogin').value = login;
                        document.getElementById('editNom').value = nom;
                        document.getElementById('editPrenom').value = prenom;
                        document.getElementById('editRole').value = role;
                        document.getElementById('editActif').value = actif ? 'true' : 'false';
                        document.getElementById('editModal').classList.add('active');
                    }

                    function closeModal(modalId) {
                        document.getElementById(modalId).classList.remove('active');
                    }

                    function confirmDelete(userId, userName) {
                        if (confirm('Êtes-vous sûr de vouloir supprimer ' + userName + ' ?')) {
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/users';

                            const actionInput = document.createElement('input');
                            actionInput.type = 'hidden';
                            actionInput.name = 'action';
                            actionInput.value = 'delete';

                            const userIdInput = document.createElement('input');
                            userIdInput.type = 'hidden';
                            userIdInput.name = 'userId';
                            userIdInput.value = userId;

                            form.appendChild(actionInput);
                            form.appendChild(userIdInput);
                            document.body.appendChild(form);
                            form.submit();
                        }
                    }

                    // Close modals on outside click
                    window.onclick = function (event) {
                        if (event.target.classList.contains('modal')) {
                            event.target.classList.remove('active');
                        }
                    }
                </script>
            </body>

            </html>