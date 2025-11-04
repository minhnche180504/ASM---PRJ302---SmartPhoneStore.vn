// Phone Shop Main JavaScript

// Initialize tooltips
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap tooltips if available
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Form validation
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
});

// Cart quantity update
function updateCartQuantity(productId, quantity) {
    if (quantity <= 0) {
        if (confirm('Bạn có muốn xóa sản phẩm này khỏi giỏ hàng?')) {
            // Remove from cart
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/cart';
            
            var actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'remove';
            
            var productInput = document.createElement('input');
            productInput.type = 'hidden';
            productInput.name = 'productId';
            productInput.value = productId;
            
            form.appendChild(actionInput);
            form.appendChild(productInput);
            document.body.appendChild(form);
            form.submit();
        }
    } else {
        // Update quantity
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/cart';
        
        var actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'update';
        
        var productInput = document.createElement('input');
        productInput.type = 'hidden';
        productInput.name = 'productId';
        productInput.value = productId;
        
        var quantityInput = document.createElement('input');
        quantityInput.type = 'hidden';
        quantityInput.name = 'quantity';
        quantityInput.value = quantity;
        
        form.appendChild(actionInput);
        form.appendChild(productInput);
        form.appendChild(quantityInput);
        document.body.appendChild(form);
        form.submit();
    }
}

// Format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}

// Show loading spinner
function showLoading() {
    var spinner = document.createElement('div');
    spinner.className = 'spinner-border text-primary';
    spinner.setAttribute('role', 'status');
    return spinner;
}

// Confirm delete
function confirmDelete(message) {
    return confirm(message || 'Bạn có chắc muốn xóa?');
}

