<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    // Sidebar toggle
    document.addEventListener('DOMContentLoaded', function() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.getElementById('sidebar');
        const contentWrapper = document.getElementById('content-wrapper');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('toggled');
                contentWrapper.classList.toggle('full-width');
            });
        }
        
        // User dropdown toggle
        window.toggleUserDropdown = function() {
            event.stopPropagation();
            const menu = document.getElementById('userDropdownMenu');
            if (menu) {
                menu.classList.toggle('show');
            }
        };
        
        // Close dropdown on outside click
        window.addEventListener('click', function(event) {
            const userDropdown = document.querySelector('.user-info');
            const userMenu = document.getElementById('userDropdownMenu');
            if (userDropdown && userMenu && !userDropdown.contains(event.target)) {
                userMenu.classList.remove('show');
            }
            
            // Close modals on outside click
            const modals = document.getElementsByClassName('modal');
            for (var i = 0; i < modals.length; i++) {
                if (event.target == modals[i]) {
                    modals[i].classList.remove('show');
                }
            }
        });
    });
    
    // Modal functions
    function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.remove('show');
        }
    }
    
    function openModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.add('show');
        }
    }
    
    // Make functions globally available
    window.closeModal = closeModal;
    window.openModal = openModal;
</script>

