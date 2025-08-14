// Validation and Form Interaction JavaScript

class FormValidator {
    constructor(formId) {
        this.form = document.getElementById(formId);
        this.errors = {};
        this.init();
    }

    init() {
        if (this.form) {
            this.setupEventListeners();
            this.setupPasswordToggle();
            this.setupRealTimeValidation();
        }
    }

    setupEventListeners() {
        this.form.addEventListener('submit', (e) => this.handleSubmit(e));
        
        // Clear errors when user starts typing
        this.form.querySelectorAll('input').forEach(input => {
            input.addEventListener('input', () => {
                this.clearFieldError(input);
            });
        });
    }

    setupPasswordToggle() {
        const passwordToggles = document.querySelectorAll('[id^="toggle"]');
        passwordToggles.forEach(toggle => {
            toggle.addEventListener('click', (e) => {
                e.preventDefault();
                const inputId = toggle.id.replace('toggle', '').toLowerCase();
                const input = document.getElementById(inputId);
                const icon = toggle.querySelector('svg');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    this.updateEyeIcon(icon, true);
                } else {
                    input.type = 'password';
                    this.updateEyeIcon(icon, false);
                }
            });
        });
    }

    updateEyeIcon(icon, isVisible) {
        if (isVisible) {
            icon.innerHTML = '<path d="M9.88 9.88a3 3 0 1 0 4.24 4.24"/><path d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68"/><path d="M6.61 6.61A13.526 13.526 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61"/><line x1="2" y1="2" x2="22" y2="22"/>';
        } else {
            icon.innerHTML = '<path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>';
        }
    }

    setupRealTimeValidation() {
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const phoneInput = document.getElementById('phoneNumber');

        if (emailInput) {
            emailInput.addEventListener('blur', () => this.validateEmail(emailInput.value));
        }

        if (passwordInput) {
            passwordInput.addEventListener('input', () => this.validatePassword(passwordInput.value));
        }

        if (confirmPasswordInput && passwordInput) {
            confirmPasswordInput.addEventListener('input', () => {
                this.validateConfirmPassword(passwordInput.value, confirmPasswordInput.value);
            });
        }

        if (phoneInput) {
            phoneInput.addEventListener('blur', () => this.validatePhoneNumber(phoneInput.value));
        }
    }

    handleSubmit(e) {
        this.clearAllErrors();
        
        const formData = new FormData(this.form);
        const data = Object.fromEntries(formData);
        
        const isValid = this.validateAll(data);
        
        if (!isValid) {
            e.preventDefault();
            this.showErrors();
            this.scrollToFirstError();
            return false;
        }

        // Show loading state
        this.showLoadingState();
        return true;
    }

    validateAll(data) {
        let isValid = true;

        // Email validation
        if (!this.validateEmail(data.email)) {
            isValid = false;
        }

        // Password validation
        if (!this.validatePassword(data.password)) {
            isValid = false;
        }

        // Confirm password validation
        if (!this.validateConfirmPassword(data.password, data.confirmPassword)) {
            isValid = false;
        }

        // Full name validation
        if (!this.validateFullName(data.fullName)) {
            isValid = false;
        }

        // Phone number validation
        if (!this.validatePhoneNumber(data.phoneNumber)) {
            isValid = false;
        }

        // Address validation
        if (!this.validateAddress(data.address)) {
            isValid = false;
        }

        return isValid;
    }

    validateEmail(email) {
        if (!email || email.trim() === '') {
            this.addError('email', 'Email không được để trống');
            return false;
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            this.addError('email', 'Email không đúng định dạng');
            return false;
        }

        return true;
    }

    validatePassword(password) {
        if (!password || password.trim() === '') {
            this.addError('password', 'Mật khẩu không được để trống');
            return false;
        }

        if (password.length < 6) {
            this.addError('password', 'Mật khẩu phải có ít nhất 6 ký tự');
            return false;
        }

        const hasUpper = /[A-Z]/.test(password);
        const hasLower = /[a-z]/.test(password);
        const hasNumber = /\d/.test(password);

        if (!hasUpper || !hasLower || !hasNumber) {
            this.addError('password', 'Mật khẩu phải chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 số');
            return false;
        }

        return true;
    }

    validateConfirmPassword(password, confirmPassword) {
        if (!confirmPassword || confirmPassword.trim() === '') {
            this.addError('confirmPassword', 'Xác nhận mật khẩu không được để trống');
            return false;
        }

        if (password !== confirmPassword) {
            this.addError('confirmPassword', 'Mật khẩu xác nhận không khớp');
            return false;
        }

        return true;
    }

    validateFullName(fullName) {
        if (!fullName || fullName.trim() === '') {
            this.addError('fullName', 'Họ và tên không được để trống');
            return false;
        }

        if (fullName.trim().length < 2) {
            this.addError('fullName', 'Họ và tên phải có ít nhất 2 ký tự');
            return false;
        }

        return true;
    }

    validatePhoneNumber(phoneNumber) {
        if (!phoneNumber || phoneNumber.trim() === '') {
            this.addError('phoneNumber', 'Số điện thoại không được để trống');
            return false;
        }

        const phoneRegex = /^0[0-9]{9,10}$/;
        if (!phoneRegex.test(phoneNumber)) {
            this.addError('phoneNumber', 'Số điện thoại không đúng định dạng');
            return false;
        }

        return true;
    }

    validateAddress(address) {
        if (!address || address.trim() === '') {
            this.addError('address', 'Địa chỉ không được để trống');
            return false;
        }

        if (address.trim().length < 5) {
            this.addError('address', 'Địa chỉ phải có ít nhất 5 ký tự');
            return false;
        }

        return true;
    }

    addError(fieldName, message) {
        this.errors[fieldName] = message;
    }

    showErrors() {
        Object.keys(this.errors).forEach(fieldName => {
            this.showFieldError(fieldName, this.errors[fieldName]);
        });
    }

    showFieldError(fieldName, message) {
        const field = document.getElementById(fieldName);
        if (field) {
            field.classList.add('input-error');
            
            // Remove existing error message
            const existingError = field.parentNode.querySelector('.error-message');
            if (existingError) {
                existingError.remove();
            }
            
            // Add new error message
            const errorSpan = document.createElement('span');
            errorSpan.className = 'text-xs text-destructive error-message';
            errorSpan.textContent = message;
            field.parentNode.appendChild(errorSpan);
        }
    }

    clearFieldError(input) {
        const fieldName = input.id;
        if (this.errors[fieldName]) {
            delete this.errors[fieldName];
            input.classList.remove('input-error');
            
            const errorSpan = input.parentNode.querySelector('.error-message');
            if (errorSpan) {
                errorSpan.remove();
            }
        }
    }

    clearAllErrors() {
        this.errors = {};
        this.form.querySelectorAll('.input-error').forEach(input => {
            input.classList.remove('input-error');
        });
        this.form.querySelectorAll('.error-message').forEach(error => {
            if (error.tagName === 'SPAN') {
                error.remove();
            }
        });
    }

    scrollToFirstError() {
        const firstError = this.form.querySelector('.input-error');
        if (firstError) {
            firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }

    showLoadingState() {
        const submitBtn = this.form.querySelector('button[type="submit"]');
        const submitText = submitBtn.querySelector('#submitText');
        const loadingText = submitBtn.querySelector('#loadingText');
        
        if (submitBtn && submitText && loadingText) {
            submitBtn.disabled = true;
            submitText.classList.add('hidden');
            loadingText.classList.remove('hidden');
        }
    }
}

// Toast notification system
class ToastManager {
    static show(message, type = 'info', duration = 5000) {
        const toast = document.createElement('div');
        toast.className = `fixed top-4 right-4 z-50 toast ${type}`;
        
        const icon = this.getIcon(type);
        
        toast.innerHTML = `
            <div class="flex items-center gap-2">
                ${icon}
                <span>${message}</span>
            </div>
        `;
        
        document.body.appendChild(toast);
        
        // Auto remove
        setTimeout(() => {
            toast.style.opacity = '0';
            setTimeout(() => {
                if (toast.parentNode) {
                    toast.parentNode.removeChild(toast);
                }
            }, 300);
        }, duration);
    }
    
    static getIcon(type) {
        const icons = {
            success: '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6 9 17l-5-5"/></svg>',
            error: '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>',
            warning: '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>',
            info: '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/></svg>'
        };
        
        return icons[type] || icons.info;
    }
}

// Initialize form validation when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Initialize signup form validation
    const signupForm = document.getElementById('signupForm');
    if (signupForm) {
        new FormValidator('signupForm');
    }
    
    // Auto-hide existing toast messages
    const toasts = document.querySelectorAll('.toast');
    toasts.forEach(toast => {
        setTimeout(() => {
            toast.style.opacity = '0';
            setTimeout(() => {
                if (toast.parentNode) {
                    toast.parentNode.removeChild(toast);
                }
            }, 300);
        }, 5000);
    });
});

// Export for use in other scripts
window.FormValidator = FormValidator;
window.ToastManager = ToastManager;
