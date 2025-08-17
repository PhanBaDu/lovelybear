<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Button mở chat -->
<button id="chatbot" 
    class="fixed bottom-5 left-5 px-4 py-2 cursor-pointer bg-foreground text-background shadow-xs hover:bg-secondary/80 inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium transition-all">
    Bạn cần hỗ trợ gì nào ?
</button>

<!-- Popup Chatbot -->
<div id="modal-chatbot" 
    class="modal fixed bottom-20 w-[600px] h-[700px] left-5 bg-white rounded-lg shadow-lg hidden flex-col justify-between z-40">
    <!-- Header -->
    <div class="bg-primary text-white px-4 py-4 flex justify-between items-center rounded-t-lg">
        <span class="font-semibold text-sm flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-brain-cog-icon lucide-brain-cog"><path d="m10.852 14.772-.383.923"/><path d="m10.852 9.228-.383-.923"/><path d="m13.148 14.772.382.924"/><path d="m13.531 8.305-.383.923"/><path d="m14.772 10.852.923-.383"/><path d="m14.772 13.148.923.383"/><path d="M17.598 6.5A3 3 0 1 0 12 5a3 3 0 0 0-5.63-1.446 3 3 0 0 0-.368 1.571 4 4 0 0 0-2.525 5.771"/><path d="M17.998 5.125a4 4 0 0 1 2.525 5.771"/><path d="M19.505 10.294a4 4 0 0 1-1.5 7.706"/><path d="M4.032 17.483A4 4 0 0 0 11.464 20c.18-.311.892-.311 1.072 0a4 4 0 0 0 7.432-2.516"/><path d="M4.5 10.291A4 4 0 0 0 6 18"/><path d="M6.002 5.125a3 3 0 0 0 .4 1.375"/><path d="m9.228 10.852-.923-.383"/><path d="m9.228 13.148-.923.383"/><circle cx="12" cy="12" r="3"/></svg>
             Hỗ trợ trực tuyến
        </span>
        <div class="flex gap-4">
            <button id="clearChatBtn" class="text-white hover:text-gray-200 text-sm" title="Xóa hội thoại">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2-icon lucide-trash-2"><path d="M10 11v6"/><path d="M14 11v6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/><path d="M3 6h18"/><path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
            </button>
            <button id="closeModalBtn" class="cursor-pointer text-xl hover:text-gray-200">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x-icon lucide-x"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
            </button>
        </div>
    </div>

    <!-- Nội dung chat -->
    <div id="chat-body" class="flex flex-col gap-2 p-4 overflow-y-auto h-full text-sm">
        <!-- Tin nhắn sẽ được load từ localStorage -->
    </div>

    <!-- Input -->
    <div class="p-4 flex gap-4 bg-white">
        <textarea
            type="text" 
            id="chat-input"
            rows="1"
            placeholder="Nhập tin nhắn..." 
            maxlength="500"
            class="w-full px-3 py-2 text-sm bg-background border-input placeholder:text-muted-foreground  flex field-sizing-content min-h-16 w-full rounded-md border bg-transparent px-3 py-2 text-base shadow-xs transition-[color,box-shadow] outline-none md:text-sm"                                ></textarea>
        <button id="send-btn" class="w-32 px-4 py-2 cursor-pointer bg-primary text-background shadow-xs hover:bg-secondary/80 inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium transition-all">
            Gửi
        </button>
    </div>

    <!-- Footer thông tin -->
    <div class="text-xs text-gray-500 px-4 py-4 border-t border-t-red-100">
        <span id="message-count">0 tin nhắn</span> • 
        <button id="export-btn" class="text-primary hover:underline">Xuất hội thoại</button>
    </div>
</div>

<script>
    class ChatBot {
        constructor() {
            this.messages = [];
            this.isOpen = false;
            this.initElements();
            this.initEventListeners();
            this.loadChatHistory();
            this.addWelcomeMessage();
        }

        initElements() {
            this.openBtn = document.getElementById("chatbot");
            this.modal = document.getElementById("modal-chatbot");
            this.closeBtn = document.getElementById("closeModalBtn");
            this.clearBtn = document.getElementById("clearChatBtn");
            this.exportBtn = document.getElementById("export-btn");
            this.chatBody = document.getElementById("chat-body");
            this.chatInput = document.getElementById("chat-input");
            this.sendBtn = document.getElementById("send-btn");
            this.messageCount = document.getElementById("message-count");
        }

        initEventListeners() {
            // Đảm bảo elements tồn tại trước khi gắn event
            if (!this.openBtn || !this.modal) {
                console.error('Chatbot elements not found');
                return;
            }

            // Toggle modal
            this.openBtn.addEventListener("click", () => this.toggleModal());
            this.closeBtn.addEventListener("click", () => this.closeModal());

            // Gửi tin nhắn
            this.sendBtn.addEventListener("click", () => this.sendMessage());
            this.chatInput.addEventListener("keypress", (e) => {
                if (e.key === "Enter") this.sendMessage();
            });

            // Xóa hội thoại
            this.clearBtn.addEventListener("click", () => this.clearChat());

            // Xuất hội thoại
            this.exportBtn.addEventListener("click", () => this.exportChat());

            // Đóng modal khi click outside
            document.addEventListener("click", (e) => {
                if (this.isOpen && !this.modal.contains(e.target) && e.target !== this.openBtn) {
                    this.closeModal();
                }
            });
        }

        toggleModal() {
            if (this.isOpen) {
                this.closeModal();
            } else {
                this.openModal();
            }
        }

        openModal() {
            this.modal.classList.remove("hidden");
            this.modal.classList.add("flex");
            this.isOpen = true;
            if (this.chatInput) {
                this.chatInput.focus();
            }
            this.scrollToBottom();
        }

        closeModal() {
            this.modal.classList.add("hidden");
            this.modal.classList.remove("flex");
            this.isOpen = false;
        }

        addMessage(content, isUser = false) {
            const now = new Date();
            const message = {
                id: now.getTime(),
                content: content,
                isUser: isUser,
                timestamp: now.toLocaleString('vi-VN')
            };

            this.messages.push(message);
            this.renderMessage(message);
            this.saveChatHistory();
            this.updateMessageCount();
            this.scrollToBottom();
        }

        renderMessage(message) {
            if (!this.chatBody) return;

            const msgDiv = document.createElement("div");
            // Sử dụng style trực tiếp thay vì class
            msgDiv.style.display = 'flex';
            msgDiv.style.width = '100%';
            msgDiv.style.marginBottom = '0.5rem';
            msgDiv.style.justifyContent = message.isUser ? 'flex-end' : 'flex-start';
            msgDiv.setAttribute('data-message-id', message.id);

            const contentDiv = document.createElement("div");
            contentDiv.className = `px-3 py-2 rounded-lg max-w-[75%] break-words ${
                message.isUser 
                    ? 'bg-primary text-white rounded-tr-none' 
                    : 'bg-gray-200 text-gray-800 rounded-tl-none'
            }`;

            // Nội dung tin nhắn
            const textDiv = document.createElement("div");
            textDiv.textContent = message.content;
            textDiv.style.textAlign = message.isUser ? 'right' : 'left'; // Thêm căn lề text
            contentDiv.appendChild(textDiv);

            // Timestamp
            const timeSpan = document.createElement("span");
            timeSpan.className = "text-xs opacity-70 block mt-1";
            timeSpan.style.textAlign = message.isUser ? 'right' : 'left'; // Căn lề timestamp
            timeSpan.textContent = message.timestamp;
            contentDiv.appendChild(timeSpan);

            msgDiv.appendChild(contentDiv);
            this.chatBody.appendChild(msgDiv);
        }

        sendMessage() {
            const message = this.chatInput.value.trim();
            if (message === "") return;

            // Thêm tin nhắn của user
            this.addMessage(message, true);
            this.chatInput.value = "";

            // Simulate bot response
            setTimeout(() => {
                this.generateBotResponse(message);
            }, 1000);
        }

        generateBotResponse(userMessage) {
            let botResponse = "Cảm ơn bạn đã liên hệ!";

            const lowerMessage = userMessage.toLowerCase();

            if (lowerMessage.includes("sản phẩm")) {
                botResponse = "Chúng tôi có nhiều sản phẩm chất lượng cao. Bạn quan tâm đến loại sản phẩm nào cụ thể?";
            } else if (lowerMessage.includes("giá") || lowerMessage.includes("phí")) {
                botResponse = "Về vấn đề giá cả, tôi sẽ kết nối bạn với bộ phận tư vấn để được báo giá chi tiết nhất.";
            } else if (lowerMessage.includes("hỗ trợ") || lowerMessage.includes("giúp")) {
                botResponse = "Tôi luôn sẵn sàng hỗ trợ bạn! Hãy cho tôi biết cụ thể bạn cần giúp gì.";
            } else if (lowerMessage.includes("xin chào") || lowerMessage.includes("chào")) {
                botResponse = "Xin chào! Rất vui được hỗ trợ bạn hôm nay. Tôi có thể giúp gì cho bạn?";
            } else if (lowerMessage.includes("cảm ơn")) {
                botResponse = "Rất vui được giúp đỡ bạn! Nếu có thêm câu hỏi gì khác, đừng ngần ngại liên hệ.";
            }

            this.addMessage(botResponse, false);
        }

        addWelcomeMessage() {
            if (this.messages.length === 0) {
                this.addMessage("Xin chào! Tôi có thể giúp gì cho bạn?", false);
            }
        }

        clearChat() {
            if (confirm("Bạn có chắc muốn xóa toàn bộ hội thoại?")) {
                this.messages = [];
                if (this.chatBody) {
                    this.chatBody.innerHTML = "";
                }
                this.saveChatHistory();
                this.updateMessageCount();
                this.addWelcomeMessage();
            }
        }

        exportChat() {
            if (this.messages.length <= 1) {
                alert("Chưa có hội thoại để xuất!");
                return;
            }

            let chatText = "=== XUẤT HỘI THOẠI CHATBOT ===\\n";
            const now = new Date();
            chatText += "Thời gian xuất: " + now.toLocaleString('vi-VN') + "\\n";
            chatText += "Tổng số tin nhắn: " + this.messages.length + "\\n\\n";

            this.messages.forEach(msg => {
                const sender = msg.isUser ? "Bạn" : "Bot";
                chatText += "[" + msg.timestamp + "] " + sender + ": " + msg.content + "\\n";
            });

            // Tạo và download file
            try {
                const blob = new Blob([chatText], { type: 'text/plain;charset=utf-8' });
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                const now = new Date();
                a.download = "chat-export-" + now.toISOString().slice(0,10) + ".txt";
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
                window.URL.revokeObjectURL(url);
            } catch (error) {
                console.log("Không thể xuất file:", error);
                alert("Không thể xuất file. Hãy thử lại sau!");
            }
        }

        saveChatHistory() {
            try {
                // Sử dụng localStorage để lưu trữ lâu dài
                localStorage.setItem('chatbot-messages', JSON.stringify(this.messages));
            } catch (error) {
                console.log("Không thể lưu hội thoại:", error);
                // Fallback to sessionStorage nếu localStorage không hoạt động
                try {
                    sessionStorage.setItem('chatbot-messages', JSON.stringify(this.messages));
                } catch (sessionError) {
                    console.log("Cả localStorage và sessionStorage đều không hoạt động");
                }
            }
        }

        loadChatHistory() {
            try {
                // Thử load từ localStorage trước
                let saved = localStorage.getItem('chatbot-messages');
                
                // Nếu không có, thử sessionStorage
                if (!saved) {
                    saved = sessionStorage.getItem('chatbot-messages');
                }
                
                if (saved) {
                    this.messages = JSON.parse(saved);
                    this.renderAllMessages();
                    this.updateMessageCount();
                }
            } catch (error) {
                console.log("Không thể tải hội thoại:", error);
                this.messages = [];
            }
        }

        renderAllMessages() {
            if (!this.chatBody) return;
            
            this.chatBody.innerHTML = "";
            this.messages.forEach(message => {
                this.renderMessage(message);
            });
            this.scrollToBottom();
        }

        updateMessageCount() {
            if (this.messageCount) {
                this.messageCount.textContent = this.messages.length + " tin nhắn";
            }
        }

        scrollToBottom() {
            if (this.chatBody) {
                setTimeout(() => {
                    this.chatBody.scrollTop = this.chatBody.scrollHeight;
                }, 100);
            }
        }
    }

    // Khởi tạo chatbot khi DOM sẵn sàng
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            new ChatBot();
        });
    } else {
        // DOM đã sẵn sàng
        new ChatBot();
    }
</script>