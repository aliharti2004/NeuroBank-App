<!-- Pagination Controls -->
<div class="pagination">
    <div class="pagination-info">
        Affichage ${(currentPage - 1) * 10 + 1} à ${(currentPage - 1) * 10 + demandes.size()} sur ${totalItems} demandes
    </div>

    <div class="pagination-buttons">
        <!-- First Page -->
        <c:if test="${currentPage > 1}">
            <a href="?page=1&statut=${filtreStatut != null ? filtreStatut : ''}&type=${filtreType != null ? filtreType : ''}"
                class="pagination-btn" title="Première page">
                <i class="fas fa-angle-double-left"></i>
            </a>
        </c:if>

        <!-- Previous Page -->
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}&statut=${filtreStatut != null ? filtreStatut : ''}&type=${filtreType != null ? filtreType : ''}"
                class="pagination-btn" title="Page précédente">
                <i class="fas fa-angle-left"></i>
            </a>
        </c:if>

        <!-- Page Numbers -->
        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                <a href="?page=${i}&statut=${filtreStatut != null ? filtreStatut : ''}&type=${filtreType != null ? filtreType : ''}"
                    class="pagination-btn ${i == currentPage ? 'active' : ''}">
                    ${i}
                </a>
            </c:if>
        </c:forEach>

        <!-- Next Page -->
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}&statut=${filtreStatut != null ? filtreStatut : ''}&type=${filtreType != null ? filtreType : ''}"
                class="pagination-btn" title="Page suivante">
                <i class="fas fa-angle-right"></i>
            </a>
        </c:if>

        <!-- Last Page -->
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${totalPages}&statut=${filtreStatut != null ? filtreStatut : ''}&type=${filtreType != null ? filtreType : ''}"
                class="pagination-btn" title="Dernière page">
                <i class="fas fa-angle-double-right"></i>
            </a>
        </c:if>
    </div>
</div>

<style>
    /* Pagination Styles */
    .pagination {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 2rem;
        padding: 1.5rem 0;
        border-top: 1px solid var(--border-dark);
    }

    .pagination-info {
        color: var(--text-gray);
        font-size: 0.9rem;
    }

    .pagination-buttons {
        display: flex;
        gap: 0.5rem;
    }

    .pagination-btn {
        min-width: 40px;
        height: 40px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 0.5rem;
        color: var(--text-white);
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .pagination-btn:hover {
        background: var(--accent-blue);
        border-color: var(--accent-blue);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
    }

    .pagination-btn.active {
        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
        border-color: var(--accent-purple);
        box-shadow: 0 4px 12px rgba(139, 92, 246, 0.4);
    }

    .pagination-btn.active:hover {
        transform: translateY(0);
    }

    @media (max-width: 768px) {
        .pagination {
            flex-direction: column;
            gap: 1rem;
        }

        .pagination-info {
            order: 2;
        }

        .pagination-buttons {
            order: 1;
            flex-wrap: wrap;
            justify-content: center;
        }
    }
</style>