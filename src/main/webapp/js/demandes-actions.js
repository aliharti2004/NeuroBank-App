// Fonction pour analyser une demande avec IA (AJAX)
function analyserIA(idDemande) {
    const btn = document.getElementById('btn-analyse-' + idDemande);
    const badge = document.getElementById('ai-badge-' + idDemande);
    
    // Désactiver le bouton pendant l'analyse
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Analyse...';
    
    // Appel AJAX vers le servlet
    fetch(getContextPath() + '/agent/analyser-demande', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'idDemande=' + idDemande
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Déterminer la classe CSS selon le score
            let badgeClass = 'ai-badge ';
            if (data.categorieRisque === 'low') {
                badgeClass += 'ai-low';
            } else if (data.categorieRisque === 'medium') {
                badgeClass += 'ai-medium';
            } else {
                badgeClass += 'ai-high';
            }
            
            // Mettre à jour le badge
            badge.className = badgeClass;
            badge.innerHTML = '<i class="fas fa-robot"></i> ' + data.scoreRisque + '/100';
            
            // Masquer le bouton Analyser
            btn.remove();
            
            // Afficher le résultat
            alert('✅ Analyse IA réussie!\\nScore de risque: ' + data.scoreRisque + '/100\\n\\n' + data.recommandation);
        } else {
            alert('❌ Erreur: ' + data.error);
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-robot"></i> Analyser IA';
        }
    })
    .catch(error => {
        console.error('Erreur:', error);
        alert('❌ Erreur lors de l\\'analyse IA.\\nVérifiez que l\\'API Flask est démarrée sur le port 5000.');
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-robot"></i> Analyser IA';
    });
}

// Fonction pour valider une demande
function validerDemande(idDemande) {
    if (confirm('Êtes-vous sûr de vouloir VALIDER cette demande #' + idDemande + ' ?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = getContextPath() + '/agent/details';
        
        const inputId = document.createElement('input');
        inputId.type = 'hidden';
        inputId.name = 'id_demande';
        inputId.value = idDemande;
        
        const inputAction = document.createElement('input');
        inputAction.type = 'hidden';
        inputAction.name = 'action';
        inputAction.value = 'approuver';
        
        form.appendChild(inputId);
        form.appendChild(inputAction);
        document.body.appendChild(form);
        form.submit();
    }
}

// Fonction pour refuser une demande
function refuserDemande(idDemande) {
    if (confirm('Êtes-vous sûr de vouloir REFUSER cette demande #' + idDemande + ' ?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = getContextPath() + '/agent/details';
        
        const inputId = document.createElement('input');
        inputId.type = 'hidden';
        inputId.name = 'id_demande';
        inputId.value = idDemande;
        
        const inputAction = document.createElement('input');
        inputAction.type = 'hidden';
        inputAction.name = 'action';
        inputAction.value = 'rejeter';
        
        form.appendChild(inputId);
        form.appendChild(inputAction);
        document.body.appendChild(form);
        form.submit();
    }
}

// Utilitaire pour obtenir le context path
function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
}
