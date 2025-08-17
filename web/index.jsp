<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.Database"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dao.ProductImageDao"%>
<%@page import="data.models.Product"%>
<%@page import="data.models.ProductImage"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="logo-title.ico">
        <title>Trang Chủ</title>
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        
        <!-- AI Chatbot Styles -->
        <style>
            /* Floating Chat Button - FIXED BOTTOM LEFT */
            .ai-chat-button {
                position: fixed;
                bottom: 20px;
                left: 20px;
                width: 60px;
                height: 60px;
                background: linear-gradient(135deg, #4CAF50, #45a049);
                border: none;
                border-radius: 50%;
                cursor: pointer;
                z-index: 10000;
                box-shadow: 0 8px 25px rgba(76, 175, 80, 0.4);
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                color: white;
                animation: float 3s ease-in-out infinite;
            }

            .ai-chat-button:hover {
                transform: scale(1.1);
                box-shadow: 0 10px 30px rgba(76, 175, 80, 0.6);
            }

            .ai-chat-button.has-pulse::after {
                content: '';
                position: absolute;
                top: -3px;
                right: -3px;
                width: 16px;
                height: 16px;
                background: #ff4444;
                border-radius: 50%;
                border: 2px solid white;
                animation: pulse-notification 2s infinite;
            }

            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-8px); }
            }

            @keyframes pulse-notification {
                0% { transform: scale(1); opacity: 1; }
                50% { transform: scale(1.3); opacity: 0.7; }
                100% { transform: scale(1); opacity: 1; }
            }

            /* Chat Widget Popup */
            .ai-chat-widget {
                position: fixed;
                bottom: 90px;
                left: 20px;
                width: 350px;
                height: 500px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                z-index: 9999;
                display: flex;
                flex-direction: column;
                overflow: hidden;
                transform: scale(0) translateY(50px);
                opacity: 0;
                transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
                pointer-events: none;
            }

            .ai-chat-widget.show {
                transform: scale(1) translateY(0);
                opacity: 1;
                pointer-events: auto;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .ai-chat-widget {
                    left: 10px;
                    right: 10px;
                    width: calc(100vw - 20px);
                    bottom: 85px;
                    height: 70vh;
                    max-height: 450px;
                }
                
                .ai-chat-widget.show {
                    transform: scale(1) translateY(0);
                }
            }

            /* Chat Header */
            .chat-header {
                background: linear-gradient(135deg, #4CAF50, #45a049);
                color: white;
                padding: 15px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: relative;
                overflow: hidden;
            }

            .chat-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                animation: shimmer 4s infinite;
            }

            @keyframes shimmer {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            .chat-header-info {
                position: relative;
                z-index: 1;
            }

            .chat-title {
                font-size: 16px;
                font-weight: 700;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 6px;
            }

            .chat-status {
                font-size: 11px;
                opacity: 0.9;
                margin-top: 2px;
            }

            .chat-close {
                background: none;
                border: none;
                color: white;
                font-size: 20px;
                cursor: pointer;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                transition: background 0.3s ease;
                position: relative;
                z-index: 1;
            }

            .chat-close:hover {
                background: rgba(255,255,255,0.2);
            }

            /* Chat Messages */
            .chat-messages {
                flex: 1;
                padding: 15px;
                overflow-y: auto;
                background: #f8f9fa;
                background-image: radial-gradient(circle at 1px 1px, rgba(0,0,0,0.05) 1px, transparent 0);
                background-size: 15px 15px;
            }

            .message {
                margin-bottom: 12px;
                display: flex;
                align-items: flex-end;
                animation: messageSlide 0.3s ease-out;
            }

            @keyframes messageSlide {
                from {
                    opacity: 0;
                    transform: translateY(15px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .message.user {
                justify-content: flex-end;
            }

            .message.bot {
                justify-content: flex-start;
            }

            .message-bubble {
                max-width: 80%;
                padding: 10px 14px;
                border-radius: 16px;
                position: relative;
                word-wrap: break-word;
                font-size: 13px;
                line-height: 1.4;
            }

            .message.user .message-bubble {
                background: linear-gradient(135deg, #007bff, #0056b3);
                color: white;
                border-bottom-right-radius: 4px;
            }

            .message.bot .message-bubble {
                background: white;
                color: #333;
                border: 1px solid #e0e0e0;
                border-bottom-left-radius: 4px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }

            .message-time {
                font-size: 10px;
                color: #888;
                margin: 0 6px;
                align-self: flex-end;
            }

            /* Quick Actions */
            .quick-actions {
                display: flex;
                gap: 6px;
                padding: 8px 15px;
                flex-wrap: wrap;
                background: #f8f9fa;
            }

            .quick-action {
                background: #e3f2fd;
                border: 1px solid #2196F3;
                color: #2196F3;
                padding: 4px 8px;
                border-radius: 10px;
                font-size: 10px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .quick-action:hover {
                background: #2196F3;
                color: white;
                transform: translateY(-1px);
            }

            /* Typing Indicator */
            .typing-indicator {
                display: none;
                align-items: center;
                padding: 10px 15px;
                color: #666;
                font-style: italic;
                font-size: 11px;
                background: #f8f9fa;
            }

            .typing-dots {
                display: inline-flex;
                margin-left: 6px;
            }

            .typing-dots span {
                height: 5px;
                width: 5px;
                background-color: #4CAF50;
                border-radius: 50%;
                display: inline-block;
                margin: 0 1px;
                animation: typing 1.4s infinite ease-in-out;
            }

            .typing-dots span:nth-child(1) { animation-delay: -0.32s; }
            .typing-dots span:nth-child(2) { animation-delay: -0.16s; }

            @keyframes typing {
                0%, 80%, 100% {
                    transform: scale(0.8);
                    opacity: 0.5;
                }
                40% {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            /* Chat Input */
            .chat-input-container {
                padding: 12px 15px;
                background: white;
                border-top: 1px solid #e0e0e0;
            }

            .input-wrapper {
                display: flex;
                align-items: center;
                background: #f5f5f5;
                border-radius: 20px;
                padding: 3px;
                border: 2px solid transparent;
                transition: all 0.3s ease;
            }

            .input-wrapper.focused {
                border-color: #4CAF50;
                box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
            }

            .chat-input {
                flex: 1;
                border: none;
                padding: 8px 12px;
                font-size: 13px;
                background: transparent;
                outline: none;
                border-radius: 20px;
            }

            .voice-btn, .send-btn {
                width: 32px;
                height: 32px;
                border: none;
                border-radius: 50%;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                margin: 0 1px;
                font-size: 12px;
            }

            .voice-btn {
                background: linear-gradient(135deg, #ff6b6b, #ee5a52);
                color: white;
            }

            .voice-btn:hover {
                transform: scale(1.1);
                box-shadow: 0 4px 12px rgba(255, 107, 107, 0.4);
            }

            .voice-btn.recording {
                animation: pulse-voice 1.5s infinite;
            }

            @keyframes pulse-voice {
                0% {
                    box-shadow: 0 0 0 0 rgba(255, 107, 107, 0.7);
                }
                70% {
                    box-shadow: 0 0 0 8px rgba(255, 107, 107, 0);
                }
                100% {
                    box-shadow: 0 0 0 0 rgba(255, 107, 107, 0);
                }
            }

            .send-btn {
                background: linear-gradient(135deg, #4CAF50, #45a049);
                color: white;
            }

            .send-btn:hover {
                transform: scale(1.1);
                box-shadow: 0 4px 12px rgba(76, 175, 80, 0.4);
            }

            .send-btn:disabled {
                background: #ccc;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }
        </style>
    </head>
    <body> 
        <div class="flex flex-col min-h-screen justify-between bg-muted">
            <jsp:include page="./components/header.jsp" />
            <div class="pt-24 px-5 w-full pb-32 bg-muted">
                <div class="max-w-6xl mx-auto">
                    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                        <% 
                        try {
                            // Lấy danh sách sản phẩm trực tiếp từ database
                            ProductDao productDao = Database.getProductDao();
                            ProductImageDao imageDao = Database.getProductImageDao();
                            
                            List<Product> products = productDao.getAllProducts();
                            
                            if (products != null && !products.isEmpty()) {
                                for (Product product : products) {
                                    // Lấy ảnh cho sản phẩm
                                    List<ProductImage> images = imageDao.getProductImagesByProductId(product.getId());
                                    String mainImageUrl = null;
                                    if (images != null && !images.isEmpty()) {
                                        mainImageUrl = images.get(0).getImageUrl();
                                    }
                        %>
                            <a href="product?id=<%= product.getId() %>" class="block rounded-lg overflow-hidden h-96 bg-card hover:shadow-xl transition-shadow">
                                <div class="h-[70%] w-full overflow-hidden">
                                    <% if (mainImageUrl != null && !mainImageUrl.isEmpty()) { %>
                                        <img class="h-full w-full object-cover hover:scale-105 transition-transform duration-300" 
                                             src="<%= request.getContextPath() + mainImageUrl %>" 
                                             alt="<%= product.getName() %>" />
                                    <% } else { %>
                                        <div class="h-full w-full bg-muted flex items-center justify-center">
                                            <svg class="w-16 h-16 text-muted-foreground" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                            </svg>
                                        </div>
                                    <% } %>
                                </div>
                                <div class="h-[30%] p-4 flex flex-col justify-between gap-2">
                                    <div class="overflow-hidden">
                                        <h3 class="text-sm font-medium text-foreground line-clamp-2">
                                            <%= product.getName() %>
                                        </h3>
                                        <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                                            <p class="text-xs text-muted-foreground line-clamp-1 mt-1">
                                                <%= product.getDescription() %>
                                            </p>
                                        <% } %>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center gap-1">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ff2056" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <rect width="20" height="12" x="2" y="6" rx="2"/>
                                                <circle cx="12" cy="12" r="2"/>
                                                <path d="M6 12h.01M18 12h.01"/>
                                            </svg>
                                            <span class="text-primary font-semibold text-base">
                                                <%= String.format("%,.0f", product.getPrice()) %>đ
                                            </span>
                                        </div>
                                        <button class="bg-primary text-white shadow-xs hover:bg-primary/90 focus-visible:ring-primary/20 dark:focus-visible:ring-primary/40 dark:bg-primary/60 add button inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer transition-colors">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M16 10a4 4 0 0 1-8 0"/>
                                                <path d="M3.103 6.034h17.794"/>
                                                <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </a>
                        <% 
                                }
                            } else {
                        %>
                            <div class="col-span-full text-center py-12">
                                <svg class="w-16 h-16 text-muted-foreground mx-auto mb-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-database-icon lucide-database"><ellipse cx="12" cy="5" rx="9" ry="3"/><path d="M3 5V19A9 3 0 0 0 21 19V5"/><path d="M3 12A9 3 0 0 0 21 12"/></svg>
                                <h3 class="text-lg font-medium text-foreground mb-2">Chưa có sản phẩm nào</h3>
                            </div>
                        <% 
                            }
                        } catch (Exception e) {
                            System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
                            e.printStackTrace();
                        %>
                            <div class="col-span-full text-center py-12">
                                <svg class="w-16 h-16 text-red-500 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.34 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                                </svg>
                                <h3 class="text-lg font-medium text-red-600 mb-2">Có lỗi xảy ra</h3>
                                <p class="text-muted-foreground">Không thể tải danh sách sản phẩm. Vui lòng thử lại sau.</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <jsp:include page="./components/footer.jsp" />
        </div>

        <!-- AI Chatbot Widget -->
        <!-- Floating Chat Button - FIXED BOTTOM LEFT -->
        <button class="ai-chat-button has-pulse" id="aiChatBtn">
            🤖
        </button>

        <!-- Chat Widget Popup -->
        <div class="ai-chat-widget" id="aiChatWidget">
            <!-- Chat Header -->
            <div class="chat-header">
                <div class="chat-header-info">
                    <h3 class="chat-title">🤖 AI Hỗ Trợ</h3>
                    <div class="chat-status" id="chatStatus">Online - Sẵn sàng hỗ trợ</div>
                </div>
                <button class="chat-close" id="chatCloseBtn">×</button>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <button class="quick-action" onclick="sendQuickMessage('Xin chào!')">👋 Chào</button>
                <button class="quick-action" onclick="sendQuickMessage('Sản phẩm hot?')">🔥 Hot</button>
                <button class="quick-action" onclick="sendQuickMessage('Cách mua?')">🛒 Mua</button>
                <button class="quick-action" onclick="sendQuickMessage('Giao hàng?')">🚚 Ship</button>
            </div>

            <!-- Chat Messages -->
            <div class="chat-messages" id="chatMessages">
                <div class="message bot">
                    <div class="message-bubble">
                        Xin chào! 👋 Tôi là AI Assistant.<br><br>
                        Tôi có thể hỗ trợ:<br>
                        🛍️ Tư vấn sản phẩm<br>
                        📦 Hướng dẫn mua hàng<br>
                        🚚 Thông tin vận chuyển<br>
                        ❓ Giải đáp thắc mắc<br><br>
                        Hãy nhắn tin hoặc nói với tôi!
                    </div>
                    <span class="message-time" id="welcomeTime"></span>
                </div>
            </div>

            <!-- Typing Indicator -->
            <div class="typing-indicator" id="typingIndicator">
                <span>AI đang trả lời</span>
                <div class="typing-dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>

            <!-- Chat Input -->
            <div class="chat-input-container">
                <div class="input-wrapper" id="inputWrapper">
                    <input type="text" 
                           id="chatInput" 
                           class="chat-input" 
                           placeholder="Nhập tin nhắn..."
                           autocomplete="off">
                    <button class="voice-btn" id="voiceBtn" title="Nói">🎤</button>
                    <button class="send-btn" id="sendBtn" title="Gửi">➤</button>
                </div>
            </div>
        </div>

        <!-- AI Chatbot JavaScript -->
        <script>
            class AIChatbot {
                constructor() {
                    this.isOpen = false;
                    this.recognition = null;
                    this.synthesis = window.speechSynthesis;
                    this.isRecording = false;
                    this.responses = new Map();
                    
                    this.initElements();
                    this.initSpeechRecognition();
                    this.initEventListeners();
                    this.initResponses();
                    this.updateWelcomeTime();
                }

                initElements() {
                    this.chatWidget = document.getElementById('aiChatWidget');
                    this.chatMessages = document.getElementById('chatMessages');
                    this.chatInput = document.getElementById('chatInput');
                    this.sendBtn = document.getElementById('sendBtn');
                    this.voiceBtn = document.getElementById('voiceBtn');
                    this.inputWrapper = document.getElementById('inputWrapper');
                    this.typingIndicator = document.getElementById('typingIndicator');
                    this.status = document.getElementById('chatStatus');
                    this.floatBtn = document.getElementById('aiChatBtn');
                    this.closeBtn = document.getElementById('chatCloseBtn');
                }

                initSpeechRecognition() {
                    if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
                        const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
                        this.recognition = new SpeechRecognition();
                        
                        this.recognition.continuous = false;
                        this.recognition.interimResults = false;
                        this.recognition.lang = 'vi-VN';
                        
                        this.recognition.onstart = () => {
                            this.isRecording = true;
                            this.voiceBtn.classList.add('recording');
                            this.voiceBtn.textContent = '⏹️';
                            this.status.textContent = 'Đang lắng nghe...';
                        };
                        
                        this.recognition.onresult = (event) => {
                            const transcript = event.results[0][0].transcript;
                            this.chatInput.value = transcript;
                            this.sendMessage();
                        };
                        
                        this.recognition.onerror = (event) => {
                            console.error('Speech recognition error:', event.error);
                            this.stopRecording();
                        };
                        
                        this.recognition.onend = () => {
                            this.stopRecording();
                        };
                    }
                }

                initEventListeners() {
                    this.sendBtn.addEventListener('click', () => this.sendMessage());
                    
                    this.chatInput.addEventListener('keypress', (e) => {
                        if (e.key === 'Enter') {
                            this.sendMessage();
                        }
                    });

                    this.chatInput.addEventListener('focus', () => {
                        this.inputWrapper.classList.add('focused');
                    });

                    this.chatInput.addEventListener('blur', () => {
                        this.inputWrapper.classList.remove('focused');
                    });
                    
                    this.voiceBtn.addEventListener('click', () => {
                        if (this.isRecording) {
                            this.stopRecording();
                        } else {
                            this.startRecording();
                        }
                    });

                    this.floatBtn.addEventListener('click', (e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        this.toggleWidget();
                    });

                    this.closeBtn.addEventListener('click', (e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        this.closeWidget();
                    });

                    // Close widget when clicking outside
                    document.addEventListener('click', (e) => {
                        if (!this.chatWidget.contains(e.target) && !this.floatBtn.contains(e.target) && this.isOpen) {
                            this.closeWidget();
                        }
                    });
                }

                initResponses() {
                    this.responses.set('chào', [
                        'Xin chào! Rất vui được hỗ trợ bạn! 😊',
                        'Chào bạn! Tôi có thể giúp gì?',
                        'Xin chào! Chúc bạn ngày tốt lành! ✨'
                    ]);

                    this.responses.set('sản phẩm', [
                        'Chúng tôi có nhiều sản phẩm chất lượng! Bạn tìm gì? 🛍️',
                        'Sản phẩm hot: điện thoại, laptop, phụ kiện... 📱',
                        'Tất cả sản phẩm đều chính hãng, giá tốt! 💯'
                    ]);

                    this.responses.set('giá', [
                        'Giá rất cạnh tranh! Xem chi tiết trên trang sản phẩm 💰',
                        'Có nhiều ưu đãi giảm giá! Kiểm tra ngay! 🎉',
                        'Giá tốt nhất thị trường + bảo hành chính hãng 👑'
                    ]);

                    this.responses.set('mua', [
                        'Mua hàng dễ dàng: Chọn sản phẩm → Giỏ hàng → Thanh toán! 🛒',
                        'Hỗ trợ nhiều hình thức thanh toán tiện lợi 💳',
                        'Đặt hàng 24/7, giao hàng nhanh chóng! ⚡'
                    ]);

                    this.responses.set('giao', [
                        'Giao hàng 2-5 ngày. FREE SHIP đơn >500k! 🚚',
                        'Giao hàng toàn quốc, nhanh chóng an toàn 📦',
                        'HCM/HN: giao 24h. Tỉnh khác: 2-3 ngày ⚡'
                    ]);

                    this.responses.set('hỗ trợ', [
                        'Luôn sẵn sàng hỗ trợ bạn 24/7! 🙋‍♀️',
                        'Hotline: 1900-1234 hoặc chat ngay đây! ☎️',
                        'Đội ngũ tư vấn chuyên nghiệp, tận tình! 💪'
                    ]);

                    this.responses.set('default', [
                        'Tôi hiểu bạn cần hỗ trợ. Nói rõ hơn nhé? 🤔',
                        'Xin lỗi, chưa hiểu. Thử cách khác? 😅',
                        'Hỏi về: sản phẩm, giá, mua hàng, giao hàng! 💡'
                    ]);
                }

                openWidget() {
                    this.isOpen = true;
                    this.chatWidget.classList.add('show');
                    this.floatBtn.classList.remove('has-pulse');
                    
                    setTimeout(() => {
                        if (this.chatInput) {
                            this.chatInput.focus();
                        }
                    }, 400);
                }

                closeWidget() {
                    this.isOpen = false;
                    this.chatWidget.classList.remove('show');
                }

                toggleWidget() {
                    if (this.isOpen) {
                        this.closeWidget();
                    } else {
                        this.openWidget();
                    }
                }

                startRecording() {
                    if (this.recognition) {
                        try {
                            this.recognition.start();
                        } catch (error) {
                            console.error('Error starting recognition:', error);
                        }
                    }
                }

                stopRecording() {
                    this.isRecording = false;
                    this.voiceBtn.classList.remove('recording');
                    this.voiceBtn.textContent = '🎤';
                    this.status.textContent = 'Online - Sẵn sàng hỗ trợ';
                    if (this.recognition) {
                        this.recognition.stop();
                    }
                }

                sendMessage(message = null) {
                    const text = message || this.chatInput.value.trim();
                    if (!text) return;

                    this.addMessage(text, 'user');
                    this.chatInput.value = '';
                    
                    this.showTyping();
                    
                    setTimeout(() => {
                        const response = this.generateResponse(text);
                        this.hideTyping();
                        this.addMessage(response, 'bot');
                        this.speakResponse(response);
                    }, Math.random() * 1500 + 800);
                }

                generateResponse(message) {
                    const lowerMessage = message.toLowerCase();
                    
                    for (let [keyword, responses] of this.responses) {
                        if (keyword !== 'default' && lowerMessage.includes(keyword)) {
                            return responses[Math.floor(Math.random() * responses.length)];
                        }
                    }
                    
                    // Pattern matching
                    if (lowerMessage.includes('bao nhiều') || lowerMessage.includes('giá cả')) {
                        return this.responses.get('giá')[Math.floor(Math.random() * this.responses.get('giá').length)];
                    }
                    
                    if (lowerMessage.includes('đặt hàng') || lowerMessage.includes('order') || lowerMessage.includes('mua')) {
                        return this.responses.get('mua')[Math.floor(Math.random() * this.responses.get('mua').length)];
                    }
                    
                    if (lowerMessage.includes('ship') || lowerMessage.includes('vận chuyển')) {
                        return this.responses.get('giao')[Math.floor(Math.random() * this.responses.get('giao').length)];
                    }
                    
                    return this.responses.get('default')[Math.floor(Math.random() * this.responses.get('default').length)];
                }

                addMessage(text, sender) {
                    const messageDiv = document.createElement('div');
                    messageDiv.className = `message ${sender}`;
                    
                    const time = new Date().toLocaleTimeString('vi-VN', {
                        hour: '2-digit',
                        minute: '2-digit'
                    });
                    
                    messageDiv.innerHTML = `
                        <div class="message-bubble">${text}</div>
                        <span class="message-time">${time}</span>
                    `;
                    
                    this.chatMessages.appendChild(messageDiv);
                    this.scrollToBottom();
                }

                speakResponse(text) {
                    if (this.synthesis && this.synthesis.speak) {
                        this.synthesis.cancel();
                        
                        // Remove emojis for better speech
                        const cleanText = text.replace(/[🤖😊✨🛍️📱💯💰🎉👑🛒💳⚡🚚📦🙋‍♀️☎️💪🤔😅💡]/g, '');
                        
                        const utterance = new SpeechSynthesisUtterance(cleanText);
                        utterance.lang = 'vi-VN';
                        utterance.rate = 0.9;
                        utterance.pitch = 1;
                        utterance.volume = 0.7;
                        
                        this.synthesis.speak(utterance);
                    }
                }

                showTyping() {
                    this.typingIndicator.style.display = 'flex';
                    this.scrollToBottom();
                }

                hideTyping() {
                    this.typingIndicator.style.display = 'none';
                }

                scrollToBottom() {
                    setTimeout(() => {
                        this.chatMessages.scrollTop = this.chatMessages.scrollHeight;
                    }, 100);
                }

                updateWelcomeTime() {
                    const welcomeTime = document.getElementById('welcomeTime');
                    if (welcomeTime) {
                        welcomeTime.textContent = new Date().toLocaleTimeString('vi-VN', {
                            hour: '2-digit',
                            minute: '2-digit'
                        });
                    }
                }
            }

            // Global function for quick actions
            function sendQuickMessage(message) {
                if (window.aiChatbot) {
                    window.aiChatbot.sendMessage(message);
                }
            }

            // Initialize chatbot when DOM is loaded
            document.addEventListener('DOMContentLoaded', () => {
                window.aiChatbot = new AIChatbot();
            });
        </script>
</html>