/**
 * Utility functions for image upload and processing
 */

class ImageUploader {
    constructor() {
        this.maxFileSize = 5 * 1024 * 1024; // 5MB
        this.allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
    }

    /**
     * Xử lý việc chọn file ảnh
     * @param {File} file - File được chọn
     * @param {Function} callback - Callback function với base64 data
     */
    handleImageSelect(file, callback) {
        // Kiểm tra kích thước file
        if (file.size > this.maxFileSize) {
            alert('File quá lớn. Vui lòng chọn file nhỏ hơn 5MB.');
            return;
        }

        // Kiểm tra loại file
        if (!this.allowedTypes.includes(file.type)) {
            alert('Chỉ chấp nhận file ảnh (JPG, PNG, GIF).');
            return;
        }

        // Đọc file và chuyển thành base64
        const reader = new FileReader();
        reader.onload = function(e) {
            const base64Data = e.target.result;
            callback(base64Data, file.name);
        };
        reader.readAsDataURL(file);
    }

    /**
     * Tạo preview ảnh
     * @param {string} base64Data - Dữ liệu base64
     * @param {HTMLElement} previewElement - Element để hiển thị preview
     */
    createPreview(base64Data, previewElement) {
        if (previewElement) {
            previewElement.src = base64Data;
            previewElement.style.display = 'block';
        }
    }

    /**
     * Xử lý drag and drop
     * @param {HTMLElement} dropZone - Element drop zone
     * @param {Function} callback - Callback function
     */
    setupDragAndDrop(dropZone, callback) {
        dropZone.addEventListener('dragover', function(e) {
            e.preventDefault();
            dropZone.classList.add('drag-over');
        });

        dropZone.addEventListener('dragleave', function(e) {
            e.preventDefault();
            dropZone.classList.remove('drag-over');
        });

        dropZone.addEventListener('drop', function(e) {
            e.preventDefault();
            dropZone.classList.remove('drag-over');
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                const file = files[0];
                this.handleImageSelect(file, callback);
            }
        }.bind(this));
    }
}

// Global instance
const imageUploader = new ImageUploader();

// Utility functions for forms
function setupImageUpload(formId, inputId, previewId, originalFileNameId) {
    const form = document.getElementById(formId);
    const input = document.getElementById(inputId);
    const preview = document.getElementById(previewId);
    const originalFileNameInput = document.getElementById(originalFileNameId);

    if (!form || !input) return;

    // Xử lý khi chọn file
    input.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            imageUploader.handleImageSelect(file, function(base64Data, fileName) {
                // Lưu base64 data vào hidden input
                const base64Input = form.querySelector('input[name="pictureProfileBase64"]');
                if (base64Input) {
                    base64Input.value = base64Data;
                }

                // Lưu tên file gốc
                if (originalFileNameInput) {
                    originalFileNameInput.value = fileName;
                }

                // Hiển thị preview
                if (preview) {
                    imageUploader.createPreview(base64Data, preview);
                }
            });
        }
    });

    // Setup drag and drop nếu có drop zone
    const dropZone = form.querySelector('.drop-zone');
    if (dropZone) {
        imageUploader.setupDragAndDrop(dropZone, function(base64Data, fileName) {
            const base64Input = form.querySelector('input[name="pictureProfileBase64"]');
            if (base64Input) {
                base64Input.value = base64Data;
            }

            if (originalFileNameInput) {
                originalFileNameInput.value = fileName;
            }

            if (preview) {
                imageUploader.createPreview(base64Data, preview);
            }
        });
    }
}

// Auto setup cho form signup
document.addEventListener('DOMContentLoaded', function() {
    setupImageUpload(
        'signupForm', 
        'profileImage', 
        'imagePreview', 
        'originalFileName'
    );
});
