<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Button mở chat -->
<button
  class="fixed z-50 text-background bottom-10 left-5 cursor-pointer text-secondary-foreground shadow-xs hover:bg-secondary/80 inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium transition-all bg-primary"
>
  <svg
    id="chatbot"
    data-logo="logo"
    class="w-12 h-12 p-2 overflow-hidden"
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 51 41"
  >
    <g id="logogram" transform="translate(0, 0) rotate(0) ">
      <path
        d="M13.0832 0.429993L23.4173 9.25886C24.0309 9.78301 24.3845 10.5522 24.3845 11.3623V18.0162L14.0503 9.18733C13.4368 8.66319 13.0832 7.894 13.0832 7.08386V0.429993Z"
        fill="#fff"
      />
      <path
        d="M13.0832 40.43L23.4173 31.6011C24.0309 31.077 24.3845 30.3078 24.3845 29.4977V22.8438L14.0503 31.6727C13.4368 32.1968 13.0832 32.966 13.0832 33.7761V40.43Z"
        fill="#fff"
      />
      <path
        d="M0.754395 9.74034L10.948 18.4005C11.4422 18.8204 12.0681 19.0507 12.7147 19.0507H20.9354L10.7669 10.3925C10.2723 9.9714 9.64557 9.74034 8.99786 9.74034H0.754395Z"
        fill="#fff"
      />
      <path
        d="M0.754395 31.1196L10.8853 22.4645C11.3804 22.0415 12.0086 21.8093 12.6578 21.8093H20.9599L10.7663 30.4694C10.2721 30.8893 9.64625 31.1196 8.99957 31.1196H0.754395Z"
        fill="#fff"
      />
      <path
        d="M38.4256 0.429993L28.0914 9.25886C27.4779 9.78301 27.1243 10.5522 27.1243 11.3623V18.0162L37.4584 9.18733C38.072 8.66319 38.4256 7.894 38.4256 7.08386V0.429993Z"
        fill="#fff"
      />
      <path
        d="M38.4256 40.43L28.0914 31.6011C27.4779 31.077 27.1243 30.3078 27.1243 29.4977V22.8438L37.4584 31.6727C38.072 32.1968 38.4256 32.966 38.4256 33.7761V40.43Z"
        fill="#fff"
      />
      <path
        d="M50.7544 9.74034L40.5608 18.4005C40.0666 18.8204 39.4407 19.0507 38.7941 19.0507H30.5733L40.7419 10.3925C41.2364 9.9714 41.8632 9.74034 42.5109 9.74034H50.7544Z"
        fill="#fff"
      />
      <path
        d="M50.7544 31.1196L40.6235 22.4645C40.1284 22.0415 39.5002 21.8093 38.851 21.8093H30.5489L40.7425 30.4694C41.2367 30.8893 41.8625 31.1196 42.5092 31.1196H50.7544Z"
        fill="#fff"
      />
    </g>
    <g id="logotype" transform="translate(51, 20.5)"></g>
  </svg>
</button>

<!-- Popup Chatbot -->
<div
  id="modal-chatbot"
  class="modal fixed bottom-28 w-[600px] h-[700px] left-5 bg-white rounded-lg shadow-lg hidden flex-col justify-between z-40"
  style="
    background-image: url('./public/assets/images/background.png');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
  "
>
  <!-- Header -->
  <div
    class="bg-primary text-white px-4 py-4 flex justify-between items-center rounded-t-lg"
  >
    <span class="font-semibold text-sm flex items-center gap-2">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="18"
        height="18"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
        class="lucide lucide-brain-cog-icon lucide-brain-cog"
      >
        <path d="m10.852 14.772-.383.923" />
        <path d="m10.852 9.228-.383-.923" />
        <path d="m13.148 14.772.382.924" />
        <path d="m13.531 8.305-.383.923" />
        <path d="m14.772 10.852.923-.383" />
        <path d="m14.772 13.148.923.383" />
        <path
          d="M17.598 6.5A3 3 0 1 0 12 5a3 3 0 0 0-5.63-1.446 3 3 0 0 0-.368 1.571 4 4 0 0 0-2.525 5.771"
        />
        <path d="M17.998 5.125a4 4 0 0 1 2.525 5.771" />
        <path d="M19.505 10.294a4 4 0 0 1-1.5 7.706" />
        <path
          d="M4.032 17.483A4 4 0 0 0 11.464 20c.18-.311.892-.311 1.072 0a4 4 0 0 0 7.432-2.516"
        />
        <path d="M4.5 10.291A4 4 0 0 0 6 18" />
        <path d="M6.002 5.125a3 3 0 0 0 .4 1.375" />
        <path d="m9.228 10.852-.923-.383" />
        <path d="m9.228 13.148-.923.383" />
        <circle cx="12" cy="12" r="3" />
      </svg>
      Hỗ trợ trực tuyến
    </span>
    <div class="flex gap-4">
      <button
        id="clearChatBtn"
        class="text-white hover:text-gray-200 text-sm"
        title="Xóa hội thoại"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="18"
          height="18"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
          class="lucide lucide-trash2-icon lucide-trash-2"
        >
          <path d="M10 11v6" />
          <path d="M14 11v6" />
          <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6" />
          <path d="M3 6h18" />
          <path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2" />
        </svg>
      </button>
      <button
        id="closeModalBtn"
        class="cursor-pointer text-xl hover:text-gray-200"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="18"
          height="18"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
          class="lucide lucide-x-icon lucide-x"
        >
          <path d="M18 6 6 18" />
          <path d="m6 6 12 12" />
        </svg>
      </button>
    </div>
  </div>

  <!-- Nội dung chat -->
  <div
    id="chat-body"
    class="flex flex-col gap-2 p-4 overflow-y-auto h-full text-sm"
  >
    <!-- Tin nhắn sẽ được load từ localStorage -->
  </div>

  <!-- Input -->
  <div class="p-4 flex gap-4">
    <textarea
      type="text"
      id="chat-input"
      rows="1"
      placeholder="Nhập tin nhắn..."
      maxlength="500"
      class="w-full px-3 py-2 text-sm bg-background border-input placeholder:text-muted-foreground flex field-sizing-content min-h-16 w-full rounded-md border bg-transparent px-3 py-2 text-base shadow-xs transition-[color,box-shadow] outline-none md:text-sm"
    ></textarea>
    <button
      id="send-btn"
      class="w-32 px-4 py-2 cursor-pointer bg-primary text-background shadow-xs hover:bg-secondary/80 inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium transition-all"
    >
      Gửi
    </button>
  </div>

  <!-- Footer thông tin -->
  <div class="text-xs text-background px-4 py-4 border-t border-t-red-100">
    <span id="message-count">0 tin nhắn</span> •
    <button id="export-btn" class="text-primary font-bold hover:underline">
      Xuất hội thoại
    </button>
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
        console.error("Chatbot elements not found");
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
        if (
          this.isOpen &&
          !this.modal.contains(e.target) &&
          e.target !== this.openBtn
        ) {
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
        timestamp: now.toLocaleString("vi-VN"),
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
      msgDiv.style.display = "flex";
      msgDiv.style.width = "100%";
      msgDiv.style.marginBottom = "0.5rem";
      msgDiv.style.justifyContent = message.isUser ? "flex-end" : "flex-start";
      msgDiv.setAttribute("data-message-id", message.id);

      const contentDiv = document.createElement("div");
      contentDiv.className = `px-3 py-2 rounded-lg max-w-[75%] break-words ${
        message.isUser
          ? "bg-primary text-white rounded-tr-none"
          : "bg-gray-200 text-gray-800 rounded-tl-none"
      }`;

      // Nội dung tin nhắn
      const textDiv = document.createElement("div");
      textDiv.textContent = message.content;
      textDiv.style.textAlign = message.isUser ? "right" : "left"; // Thêm căn lề text
      contentDiv.appendChild(textDiv);

      // Timestamp
      const timeSpan = document.createElement("span");
      timeSpan.className = "text-xs opacity-70 block mt-1";
      timeSpan.style.textAlign = message.isUser ? "right" : "left"; // Căn lề timestamp
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

      // Kiểm tra xem có phải là tìm kiếm trực tiếp không
      const lowerMessage = message.toLowerCase();
      const searchKeywords = [
        "tìm",
        "tìm kiếm",
        "search",
        "kiếm",
        "cần",
        "muốn",
        "mua",
      ];
      const isDirectSearch =
        searchKeywords.some((keyword) => lowerMessage.includes(keyword)) &&
        !lowerMessage.includes("sản phẩm") &&
        !lowerMessage.includes("giá") &&
        !lowerMessage.includes("rẻ");

      if (isDirectSearch) {
        // Nếu là tìm kiếm trực tiếp, thực hiện tìm kiếm ngay
        setTimeout(() => {
          this.searchProducts(message);
        }, 500);
      } else {
        // Simulate bot response
        setTimeout(() => {
          this.generateBotResponse(message);
        }, 1000);
      }
    }

    generateBotResponse(userMessage) {
      let botResponse = "Cảm ơn bạn đã liên hệ!";
      let shouldShowCheapButton = false;
      let shouldShowProductButton = false;
      let shouldShowTopSellingButton = false;
      let shouldShowSearchButton = false;

      const lowerMessage = userMessage.toLowerCase();

      // Kiểm tra các từ khóa liên quan đến sản phẩm giá rẻ
      const cheapKeywords = [
        "rẻ",
        "giá rẻ",
        "giá thấp",
        "giá tốt",
        "giá ưu đãi",
        "khuyến mãi",
        "giảm giá",
        "sale",
        "deal",
      ];
      const hasCheapKeyword = cheapKeywords.some((keyword) =>
        lowerMessage.includes(keyword)
      );

      // Kiểm tra từ khóa tìm kiếm
      const searchKeywords = [
        "tìm",
        "tìm kiếm",
        "search",
        "kiếm",
        "cần",
        "muốn",
        "mua",
        "đang tìm",
        "đang kiếm",
      ];
      const hasSearchKeyword = searchKeywords.some((keyword) =>
        lowerMessage.includes(keyword)
      );

      // Kiểm tra từ khóa top bán chạy
      const topSellingKeywords = [
        "bán chạy",
        "phổ biến",
        "nổi tiếng",
        "hot",
        "trend",
        "được ưa chuộng",
        "nhiều người mua",
        "top",
        "best seller",
      ];
      const hasTopSellingKeyword = topSellingKeywords.some((keyword) =>
        lowerMessage.includes(keyword)
      );

      if (lowerMessage.includes("sản phẩm")) {
        if (hasCheapKeyword) {
          botResponse =
            "Bạn muốn tìm sản phẩm giá rẻ phải không? Tôi sẽ tìm cho bạn những sản phẩm có giá tốt nhất!";
          shouldShowCheapButton = true;
        } else if (hasTopSellingKeyword) {
          botResponse =
            "Bạn muốn xem top sản phẩm bán chạy nhất phải không? Tôi sẽ hiển thị những sản phẩm được ưa chuộng nhất!";
          shouldShowTopSellingButton = true;
        } else if (hasSearchKeyword) {
          botResponse =
            "Bạn muốn tìm kiếm sản phẩm cụ thể phải không? Hãy cho tôi biết bạn đang tìm gì!";
          shouldShowSearchButton = true;
        } else {
          botResponse =
            "Chúng tôi có nhiều sản phẩm chất lượng cao. Bạn có muốn xem toàn bộ sản phẩm không?";
          shouldShowProductButton = true;
        }
      } else if (hasCheapKeyword) {
        botResponse =
          "Bạn muốn tìm sản phẩm giá rẻ phải không? Tôi sẽ tìm cho bạn những sản phẩm có giá tốt nhất!";
        shouldShowCheapButton = true;
      } else if (hasTopSellingKeyword) {
        botResponse =
          "Bạn muốn xem top sản phẩm bán chạy nhất phải không? Tôi sẽ hiển thị những sản phẩm được ưa chuộng nhất!";
        shouldShowTopSellingButton = true;
      } else if (hasSearchKeyword) {
        botResponse =
          "Bạn muốn tìm kiếm sản phẩm phải không? Hãy cho tôi biết cụ thể bạn đang tìm gì!";
        shouldShowSearchButton = true;
      } else if (
        lowerMessage.includes("gấu") &&
        (lowerMessage.includes("giá") || lowerMessage.includes("rẻ"))
      ) {
        botResponse =
          "Bạn muốn tìm sản phẩm gấu giá tốt nhất phải không? Tôi sẽ tìm cho bạn những sản phẩm có giá thấp nhất!";
        shouldShowCheapButton = true;
      } else if (lowerMessage.includes("giá") || lowerMessage.includes("phí")) {
        botResponse =
          "Về vấn đề giá cả, tôi sẽ kết nối bạn với bộ phận tư vấn để được báo giá chi tiết nhất.";
      } else if (
        lowerMessage.includes("hỗ trợ") ||
        lowerMessage.includes("giúp")
      ) {
        botResponse =
          "Tôi luôn sẵn sàng hỗ trợ bạn! Hãy cho tôi biết cụ thể bạn cần giúp gì.";
      } else if (
        lowerMessage.includes("xin chào") ||
        lowerMessage.includes("chào")
      ) {
        botResponse =
          "Xin chào! Rất vui được hỗ trợ bạn hôm nay. Tôi có thể giúp gì cho bạn?";
      } else if (lowerMessage.includes("cảm ơn")) {
        botResponse =
          "Rất vui được giúp đỡ bạn! Nếu có thêm câu hỏi gì khác, đừng ngần ngại liên hệ.";
      }

      this.addMessage(botResponse, false);

      // Hiển thị button phù hợp sau khi gửi tin nhắn
      setTimeout(() => {
        if (shouldShowCheapButton) {
          this.addCheapProductButton();
        } else if (shouldShowProductButton) {
          this.addProductButton();
        } else if (shouldShowTopSellingButton) {
          this.addTopSellingButton();
        } else if (shouldShowSearchButton) {
          this.addSearchButton();
        }
      }, 100);
    }

    addWelcomeMessage() {
      if (this.messages.length === 0) {
        this.addMessage(
          "Xin chào! Tôi có thể giúp gì cho bạn? Bạn có thể hỏi về sản phẩm, giá cả, tìm sản phẩm giá rẻ hoặc các vấn đề khác.",
          false
        );

        // Thêm options cho người dùng
        this.addOptions();
      }
    }

    // Thêm options cho người dùng
    addOptions() {
      if (!this.chatBody) return;

      const optionsDiv = document.createElement("div");
      optionsDiv.style.display = "flex";
      optionsDiv.style.width = "100%";
      optionsDiv.style.marginBottom = "0.5rem";
      optionsDiv.style.justifyContent = "flex-start";
      optionsDiv.style.flexWrap = "wrap";
      optionsDiv.style.gap = "8px";

      const options = [
        {
          text: "🛍️ Xem tất cả sản phẩm",
          action: () => this.showProducts(),
          color: "bg-primary",
        },
        {
          text: "💰 Sản phẩm giá rẻ",
          action: () => this.showCheapProducts(),
          color: "bg-primary",
        },
        {
          text: "🔥 Top bán chạy",
          action: () => this.showTopSellingProducts(),
          color: "bg-orange-500",
        },
        {
          text: "🔍 Tìm kiếm sản phẩm",
          action: () => this.showSearchOption(),
          color: "bg-blue-500",
        },
        {
          text: "📞 Liên hệ hỗ trợ",
          action: () => this.showContactInfo(),
          color: "bg-purple-500",
        },
      ];

      options.forEach((option) => {
        const button = document.createElement("button");
        button.className = `px-3 py-2 text-white rounded-lg hover:opacity-90 transition-all text-xs font-medium ${option.color}`;
        button.textContent = option.text;
        button.onclick = option.action;
        optionsDiv.appendChild(button);
      });

      this.chatBody.appendChild(optionsDiv);
      this.scrollToBottom();
    }

    // Hiển thị tùy chọn tìm kiếm
    showSearchOption() {
      this.addMessage(
        "Bạn muốn tìm sản phẩm gì? Hãy nhập từ khóa tìm kiếm vào ô chat bên dưới.",
        false
      );

      // Thêm hướng dẫn tìm kiếm
      setTimeout(() => {
        this.addSearchGuide();
      }, 500);
    }

    // Thêm hướng dẫn tìm kiếm
    addSearchGuide() {
      if (!this.chatBody) return;

      const guideDiv = document.createElement("div");
      guideDiv.style.display = "flex";
      guideDiv.style.width = "100%";
      guideDiv.style.marginBottom = "0.5rem";
      guideDiv.style.justifyContent = "flex-start";

      const guideContainer = document.createElement("div");
      guideContainer.className =
        "bg-blue-50 rounded-lg p-3 max-w-full border border-blue-200";

      guideContainer.innerHTML =
        '<div class="text-sm text-gray-700">' +
        '<p class="font-semibold mb-2">💡 Gợi ý từ khóa tìm kiếm:</p>' +
        '<ul class="text-xs space-y-1">' +
        "<li>• <strong>Phong cách:</strong> hiện đại, cổ điển, minimalist</li>" +
        "<li>• <strong>Không gian:</strong> phòng khách, phòng ngủ, văn phòng</li>" +
        "<li>• <strong>Màu sắc:</strong> trắng, đen, vàng, xanh</li>" +
        "<li>• <strong>Chất liệu:</strong> gỗ, kim loại, vải, nhựa</li>" +
        "<li>• <strong>Kích thước:</strong> nhỏ, vừa, lớn</li>" +
        "</ul>" +
        "</div>";

      guideDiv.appendChild(guideContainer);
      this.chatBody.appendChild(guideDiv);
      this.scrollToBottom();
    }

    // Tìm kiếm sản phẩm theo từ khóa
    async searchProducts(searchTerm) {
      if (!searchTerm || searchTerm.trim() === "") {
        this.addMessage("Vui lòng nhập từ khóa tìm kiếm!", false);
        return;
      }

      try {
        // Hiển thị loading
        this.addMessage(
          `🔍 Đang tìm kiếm sản phẩm với từ khóa: "${searchTerm}"...`,
          false
        );

        // Lấy danh sách sản phẩm từ server
        const response = await fetch(
          window.location.pathname.replace("/index.jsp", "") + "/api/products"
        );
        if (!response.ok) {
          throw new Error("Không thể tải sản phẩm");
        }

        const allProducts = await response.json();

        // Xóa tin nhắn loading
        this.removeLastMessage();

        // Tìm kiếm sản phẩm theo từ khóa
        const searchResults = this.filterProductsByKeyword(
          allProducts,
          searchTerm
        );

        if (searchResults.length === 0) {
          this.addMessage(
            `Không tìm thấy sản phẩm nào phù hợp với từ khóa "${searchTerm}". Hãy thử từ khóa khác hoặc xem tất cả sản phẩm!`,
            false
          );

          // Gợi ý từ khóa tương tự
          setTimeout(() => {
            this.suggestSimilarKeywords(searchTerm, allProducts);
          }, 500);
        } else {
          this.addMessage(
            `🎉 Tìm thấy ${searchResults.length} sản phẩm phù hợp với từ khóa "${searchTerm}":`,
            false
          );

          // Hiển thị kết quả tìm kiếm
          setTimeout(() => {
            this.displaySearchResults(searchResults, searchTerm);
          }, 500);
        }
      } catch (error) {
        console.error("Lỗi khi tìm kiếm sản phẩm:", error);
        this.removeLastMessage();
        this.addMessage(
          "Xin lỗi, không thể thực hiện tìm kiếm. Vui lòng thử lại sau.",
          false
        );
      }
    }

    // Lọc sản phẩm theo từ khóa
    filterProductsByKeyword(products, keyword) {
      const lowerKeyword = keyword.toLowerCase();
      return products.filter((product) => {
        // Tìm kiếm trong tên sản phẩm
        if (product.name && product.name.toLowerCase().includes(lowerKeyword)) {
          return true;
        }
        // Tìm kiếm trong mô tả
        if (
          product.description &&
          product.description.toLowerCase().includes(lowerKeyword)
        ) {
          return true;
        }
        // Tìm kiếm trong danh mục (nếu có)
        if (
          product.category &&
          product.category.toLowerCase().includes(lowerKeyword)
        ) {
          return true;
        }
        // Tìm kiếm theo phong cách (nếu có)
        if (
          product.style &&
          product.style.toLowerCase().includes(lowerKeyword)
        ) {
          return true;
        }
        return false;
      });
    }

    // Gợi ý từ khóa tương tự
    suggestSimilarKeywords(searchTerm, products) {
      if (!this.chatBody) return;

      // Tạo danh sách từ khóa phổ biến
      const commonKeywords = [
        "gấu bông",
        "gối trang trí",
        "khung ảnh",
        "bình hoa",
        "đèn trang trí",
        "tranh treo tường",
        "đồng hồ",
        "lọ hoa",
        "bình phong",
        "thảm trang trí",
        "gối sofa",
        "chăn ga",
        "rèm cửa",
        "bàn trang điểm",
        "giá sách",
      ];

      // Tìm từ khóa tương tự
      const suggestions = commonKeywords.filter(
        (keyword) =>
          keyword.toLowerCase().includes(searchTerm.toLowerCase()) ||
          searchTerm.toLowerCase().includes(keyword.toLowerCase())
      );

      if (suggestions.length > 0) {
        const suggestionDiv = document.createElement("div");
        suggestionDiv.style.display = "flex";
        suggestionDiv.style.width = "100%";
        suggestionDiv.style.marginBottom = "0.5rem";
        suggestionDiv.style.justifyContent = "flex-start";

        const suggestionContainer = document.createElement("div");
        suggestionContainer.className =
          "bg-yellow-50 rounded-lg p-3 max-w-full border border-yellow-200";

        // Tạo HTML content một cách an toàn
        const buttonsHtml = suggestions
          .slice(0, 6)
          .map((keyword) => {
            return (
              "<button onclick=\"chatbot.searchProducts('" +
              keyword.replace(/'/g, "\\'") +
              "')\" " +
              'class="px-2 py-1 bg-yellow-100 text-yellow-800 text-xs rounded hover:bg-yellow-200 transition-colors">' +
              keyword +
              "</button>"
            );
          })
          .join("");

        suggestionContainer.innerHTML =
          '<div class="text-sm text-gray-700">' +
          '<p class="font-semibold mb-2">💡 Có thể bạn đang tìm:</p>' +
          '<div class="flex flex-wrap gap-2">' +
          buttonsHtml +
          "</div>" +
          "</div>";

        suggestionDiv.appendChild(suggestionContainer);
        this.chatBody.appendChild(suggestionDiv);
        this.scrollToBottom();
      }
    }

    // Hiển thị kết quả tìm kiếm
    displaySearchResults(searchResults, searchTerm) {
      if (!this.chatBody || !searchResults || searchResults.length === 0)
        return;

      const resultsDiv = document.createElement("div");
      resultsDiv.style.display = "flex";
      resultsDiv.style.width = "100%";
      resultsDiv.style.marginBottom = "0.5rem";
      resultsDiv.style.justifyContent = "flex-start";

      const resultsContainer = document.createElement("div");
      resultsContainer.className =
        "bg-green-50 rounded-lg p-3 max-w-full border border-green-200";
      resultsContainer.style.maxHeight = "400px";
      resultsContainer.style.overflowY = "auto";

      // Tiêu đề kết quả
      const headerDiv = document.createElement("div");
      headerDiv.className = "mb-3";

      const title = document.createElement("h3");
      title.className = "text-sm font-semibold text-green-800";
      title.textContent = `🔍 Kết quả tìm kiếm: "${searchTerm}"`;

      const subtitle = document.createElement("p");
      subtitle.className = "text-xs text-green-700 mt-1";
      subtitle.textContent = `Tìm thấy ${searchResults.length} sản phẩm phù hợp`;

      headerDiv.appendChild(title);
      headerDiv.appendChild(subtitle);
      resultsContainer.appendChild(headerDiv);

      // Danh sách sản phẩm tìm được
      const productsList = document.createElement("div");
      productsList.className = "space-y-2";

      searchResults.forEach((product, index) => {
        const productItem = this.createSearchResultItem(product, index + 1);
        productsList.appendChild(productItem);
      });

      resultsContainer.appendChild(productsList);
      resultsDiv.appendChild(resultsContainer);
      this.chatBody.appendChild(resultsDiv);
      this.scrollToBottom();
    }

    // Tạo item kết quả tìm kiếm
    createSearchResultItem(product, rank) {
      const item = document.createElement("div");
      item.className =
        "bg-white rounded-lg p-3 border border-green-200 hover:shadow-md transition-shadow cursor-pointer";
      item.onclick = () => this.showProductDetail(product);

      const mainDiv = document.createElement("div");
      mainDiv.className = "flex items-center gap-3";

      // Rank badge
      const rankBadge = document.createElement("div");
      rankBadge.className =
        "flex-shrink-0 w-6 h-6 bg-green-500 text-white rounded-full flex items-center justify-center text-xs font-bold";
      rankBadge.textContent = rank;

      // Ảnh sản phẩm
      const image = document.createElement("img");
      image.src =
        product.imageUrl ||
        window.location.pathname.replace("/index.jsp", "") +
          "/public/assets/images/product-placeholder.svg";
      image.alt = product.name;
      image.className = "w-14 h-14 object-cover rounded-md flex-shrink-0";

      // Thông tin sản phẩm
      const infoDiv = document.createElement("div");
      infoDiv.className = "flex-1 min-w-0";

      const name = document.createElement("div");
      name.className = "text-sm font-semibold text-gray-800 mb-1 line-clamp-2";
      name.textContent = product.name;
      name.style.display = "-webkit-box";
      name.style.webkitLineClamp = "2";
      name.style.webkitBoxOrient = "vertical";
      name.style.overflow = "hidden";

      const price = document.createElement("div");
      price.className = "text-sm font-bold text-green-600";
      price.textContent =
        product.formattedPrice || this.formatPrice(product.price) + "đ";

      const viewButton = document.createElement("button");
      viewButton.className =
        "mt-2 px-3 py-1 bg-green-500 text-white text-xs rounded hover:bg-green-600 transition-colors";
      viewButton.textContent = "Xem chi tiết";
      viewButton.onclick = (e) => {
        e.stopPropagation();
        this.showProductDetail(product);
      };

      infoDiv.appendChild(name);
      infoDiv.appendChild(price);
      infoDiv.appendChild(viewButton);

      mainDiv.appendChild(rankBadge);
      mainDiv.appendChild(image);
      mainDiv.appendChild(infoDiv);

      item.appendChild(mainDiv);
      return item;
    }

    // Hiển thị top 5 sản phẩm bán chạy nhất
    async showTopSellingProducts() {
      try {
        // Hiển thị loading
        this.addMessage("🔥 Đang tải top 5 sản phẩm bán chạy nhất...", false);

        // Lấy danh sách sản phẩm từ server
        const response = await fetch(
          window.location.pathname.replace("/index.jsp", "") + "/api/products"
        );
        if (!response.ok) {
          throw new Error("Không thể tải sản phẩm");
        }

        const products = await response.json();

        // Xóa tin nhắn loading
        this.removeLastMessage();

        if (products.length === 0) {
          this.addMessage("Không có sản phẩm nào để hiển thị.", false);
          return;
        }

        // Giả lập dữ liệu bán chạy (trong thực tế sẽ lấy từ database)
        const topSellingProducts = this.simulateTopSellingProducts(products);

        // Hiển thị top sản phẩm bán chạy
        this.displayTopSellingProducts(topSellingProducts);
      } catch (error) {
        console.error("Lỗi khi tải top sản phẩm bán chạy:", error);
        this.removeLastMessage();
        this.addMessage(
          "Xin lỗi, không thể tải top sản phẩm bán chạy. Vui lòng thử lại sau.",
          false
        );
      }
    }

    // Giả lập dữ liệu sản phẩm bán chạy (trong thực tế sẽ lấy từ database)
    simulateTopSellingProducts(products) {
      // Sắp xếp theo giá (giả sử sản phẩm giá trung bình bán chạy hơn)
      const sortedProducts = [...products].sort((a, b) => {
        const avgPrice =
          products.reduce((sum, p) => sum + p.price, 0) / products.length;
        const aScore = Math.abs(a.price - avgPrice);
        const bScore = Math.abs(b.price - avgPrice);
        return aScore - bScore;
      });

      // Lấy top 5
      return sortedProducts.slice(0, 5).map((product, index) => ({
        ...product,
        rank: index + 1,
        salesCount: Math.floor(Math.random() * 100) + 50, // Giả lập số lượng bán
        rating: (Math.random() * 2 + 3).toFixed(1), // Giả lập đánh giá 3-5 sao
      }));
    }

    // Hiển thị top sản phẩm bán chạy
    displayTopSellingProducts(topProducts) {
      if (!this.chatBody || !topProducts || topProducts.length === 0) {
        this.addMessage("Không có sản phẩm nào để hiển thị.", false);
        return;
      }

      const productsDiv = document.createElement("div");
      productsDiv.style.display = "flex";
      productsDiv.style.width = "100%";
      productsDiv.style.marginBottom = "0.5rem";
      productsDiv.style.justifyContent = "flex-start";

      const productsContainer = document.createElement("div");
      productsContainer.className =
        "bg-orange-50 rounded-lg p-3 max-w-full border border-orange-200";
      productsContainer.style.maxHeight = "450px";
      productsContainer.style.overflowY = "auto";

      // Tiêu đề
      const headerDiv = document.createElement("div");
      headerDiv.className = "mb-3";

      const title = document.createElement("h3");
      title.className = "text-sm font-semibold text-orange-800";
      title.textContent = "🔥 Top 5 Sản Phẩm Bán Chạy Nhất";

      const subtitle = document.createElement("p");
      subtitle.className = "text-xs text-orange-700 mt-1";
      subtitle.textContent =
        "Dựa trên số lượng đơn hàng và đánh giá của khách hàng";

      headerDiv.appendChild(title);
      headerDiv.appendChild(subtitle);
      productsContainer.appendChild(headerDiv);

      // Danh sách top sản phẩm
      const productsList = document.createElement("div");
      productsList.className = "space-y-3";

      topProducts.forEach((product) => {
        const productItem = this.createTopSellingItem(product);
        productsList.appendChild(productItem);
      });

      productsContainer.appendChild(productsList);
      productsDiv.appendChild(productsContainer);
      this.chatBody.appendChild(productsDiv);
      this.scrollToBottom();
    }

    // Tạo item top sản phẩm bán chạy
    createTopSellingItem(product) {
      const item = document.createElement("div");
      item.className =
        "bg-white rounded-lg p-3 border border-orange-200 hover:shadow-md transition-shadow cursor-pointer";
      item.onclick = () => this.showProductDetail(product);

      const mainDiv = document.createElement("div");
      mainDiv.className = "flex items-center gap-3";

      // Rank badge với icon lửa
      const rankBadge = document.createElement("div");
      rankBadge.className =
        "flex-shrink-0 w-10 h-10 bg-gradient-to-br from-orange-400 to-red-500 text-white rounded-full flex items-center justify-center text-sm font-bold relative";
      rankBadge.innerHTML =
        product.rank + '<div class="absolute -top-1 -right-1 text-xs">🔥</div>';

      // Ảnh sản phẩm
      const image = document.createElement("img");
      image.src =
        product.imageUrl ||
        window.location.pathname.replace("/index.jsp", "") +
          "/public/assets/images/product-placeholder.svg";
      image.alt = product.name;
      image.className = "w-16 h-16 object-cover rounded-md flex-shrink-0";

      // Thông tin sản phẩm
      const infoDiv = document.createElement("div");
      infoDiv.className = "flex-1 min-w-0";

      const name = document.createElement("div");
      name.className = "text-sm font-semibold text-gray-800 mb-1 line-clamp-2";
      name.textContent = product.name;
      name.style.display = "-webkit-box";
      name.style.webkitLineClamp = "2";
      name.style.webkitBoxOrient = "vertical";
      name.style.overflow = "hidden";

      const price = document.createElement("div");
      price.className = "text-sm font-bold text-orange-600 mb-1";
      price.textContent =
        product.formattedPrice || this.formatPrice(product.price) + "đ";

      // Thông tin bán chạy
      const statsDiv = document.createElement("div");
      statsDiv.className = "flex items-center gap-3 text-xs text-gray-600 mb-2";

      const salesCount = document.createElement("span");
      salesCount.className = "flex items-center gap-1";
      salesCount.innerHTML = `📦 ${product.salesCount} đã bán`;

      const rating = document.createElement("span");
      rating.className = "flex items-center gap-1";
      rating.innerHTML = `⭐ ${product.rating}/5`;

      statsDiv.appendChild(salesCount);
      statsDiv.appendChild(rating);

      const viewButton = document.createElement("button");
      viewButton.className =
        "px-3 py-1 bg-orange-500 text-white text-xs rounded hover:bg-orange-600 transition-colors";
      viewButton.textContent = "Xem chi tiết";
      viewButton.onclick = (e) => {
        e.stopPropagation();
        this.showProductDetail(product);
      };

      infoDiv.appendChild(name);
      infoDiv.appendChild(price);
      infoDiv.appendChild(statsDiv);
      infoDiv.appendChild(viewButton);

      mainDiv.appendChild(rankBadge);
      mainDiv.appendChild(image);
      mainDiv.appendChild(infoDiv);

      item.appendChild(mainDiv);
      return item;
    }

    // Hiển thị thông tin liên hệ
    showContactInfo() {
      this.addMessage(
        "📞 Liên hệ hỗ trợ:\n• Hotline: 1900-xxxx\n• Email: support@decor.com\n• Giờ làm việc: 8h-22h (Thứ 2 - Chủ nhật)",
        false
      );
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
        // Thêm lại options sau khi xóa chat
        this.addOptions();
      }
    }

    exportChat() {
      if (this.messages.length <= 1) {
        alert("Chưa có hội thoại để xuất!");
        return;
      }

      let chatText = "=== XUẤT HỘI THOẠI CHATBOT ===\\n";
      const now = new Date();
      chatText += "Thời gian xuất: " + now.toLocaleString("vi-VN") + "\\n";
      chatText += "Tổng số tin nhắn: " + this.messages.length + "\\n\\n";

      this.messages.forEach((msg) => {
        const sender = msg.isUser ? "Bạn" : "Bot";
        chatText +=
          "[" + msg.timestamp + "] " + sender + ": " + msg.content + "\\n";
      });

      // Tạo và download file
      try {
        const blob = new Blob([chatText], { type: "text/plain;charset=utf-8" });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url;
        const now = new Date();
        a.download = "chat-export-" + now.toISOString().slice(0, 10) + ".txt";
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
        localStorage.setItem("chatbot-messages", JSON.stringify(this.messages));
      } catch (error) {
        console.log("Không thể lưu hội thoại:", error);
        // Fallback to sessionStorage nếu localStorage không hoạt động
        try {
          sessionStorage.setItem(
            "chatbot-messages",
            JSON.stringify(this.messages)
          );
        } catch (sessionError) {
          console.log("Cả localStorage và sessionStorage đều không hoạt động");
        }
      }
    }

    loadChatHistory() {
      try {
        // Thử load từ localStorage trước
        let saved = localStorage.getItem("chatbot-messages");

        // Nếu không có, thử sessionStorage
        if (!saved) {
          saved = sessionStorage.getItem("chatbot-messages");
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
      this.messages.forEach((message) => {
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

    // Thêm button "Xem toàn bộ sản phẩm"
    addProductButton() {
      if (!this.chatBody) return;

      const buttonDiv = document.createElement("div");
      buttonDiv.style.display = "flex";
      buttonDiv.style.width = "100%";
      buttonDiv.style.marginBottom = "0.5rem";
      buttonDiv.style.justifyContent = "flex-start";

      const button = document.createElement("button");
      button.className =
        "px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors text-sm font-medium";
      button.textContent = "🛍️ Xem toàn bộ sản phẩm";
      button.onclick = () => this.showProducts();

      buttonDiv.appendChild(button);
      this.chatBody.appendChild(buttonDiv);
      this.scrollToBottom();
    }

    // Thêm button "Tìm sản phẩm giá rẻ"
    addCheapProductButton() {
      if (!this.chatBody) return;

      const buttonDiv = document.createElement("div");
      buttonDiv.style.display = "flex";
      buttonDiv.style.width = "100%";
      buttonDiv.style.marginBottom = "0.5rem";
      buttonDiv.style.justifyContent = "flex-start";

      const button = document.createElement("button");
      button.className =
        "px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors text-sm font-medium";
      button.textContent = "💰 Tìm sản phẩm giá rẻ";
      button.onclick = () => this.showCheapProducts();

      buttonDiv.appendChild(button);
      this.chatBody.appendChild(buttonDiv);
      this.scrollToBottom();
    }

    // Thêm button "Top sản phẩm bán chạy"
    addTopSellingButton() {
      if (!this.chatBody) return;

      const buttonDiv = document.createElement("div");
      buttonDiv.style.display = "flex";
      buttonDiv.style.width = "100%";
      buttonDiv.style.marginBottom = "0.5rem";
      buttonDiv.style.justifyContent = "flex-start";

      const button = document.createElement("button");
      button.className =
        "px-4 py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition-colors text-sm font-medium";
      button.textContent = "🔥 Xem top sản phẩm bán chạy";
      button.onclick = () => this.showTopSellingProducts();

      buttonDiv.appendChild(button);
      this.chatBody.appendChild(buttonDiv);
      this.scrollToBottom();
    }

    // Thêm button "Tìm kiếm sản phẩm"
    addSearchButton() {
      if (!this.chatBody) return;

      const buttonDiv = document.createElement("div");
      buttonDiv.style.display = "flex";
      buttonDiv.style.width = "100%";
      buttonDiv.style.marginBottom = "0.5rem";
      buttonDiv.style.justifyContent = "flex-start";

      const button = document.createElement("button");
      button.className =
        "px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors text-sm font-medium";
      button.textContent = "🔍 Tìm kiếm sản phẩm";
      button.onclick = () => this.showSearchOption();

      buttonDiv.appendChild(button);
      this.chatBody.appendChild(buttonDiv);
      this.scrollToBottom();
    }

    // Hiển thị danh sách sản phẩm
    async showProducts() {
      try {
        // Hiển thị loading
        this.addMessage("Đang tải danh sách sản phẩm...", false);

        // Lấy danh sách sản phẩm từ server
        const response = await fetch(
          window.location.pathname.replace("/index.jsp", "") + "/api/products"
        );
        if (!response.ok) {
          throw new Error("Không thể tải sản phẩm");
        }

        const products = await response.json();

        // Xóa tin nhắn loading
        this.removeLastMessage();

        // Hiển thị sản phẩm
        this.displayProducts(products);
      } catch (error) {
        console.error("Lỗi khi tải sản phẩm:", error);
        this.removeLastMessage();
        this.addMessage(
          "Xin lỗi, không thể tải danh sách sản phẩm. Vui lòng thử lại sau.",
          false
        );
      }
    }

    // Hiển thị sản phẩm giá rẻ nhất
    async showCheapProducts() {
      try {
        // Hiển thị loading
        this.addMessage("Đang tìm sản phẩm giá rẻ nhất...", false);

        // Lấy danh sách sản phẩm từ server
        const response = await fetch(
          window.location.pathname.replace("/index.jsp", "") + "/api/products"
        );
        if (!response.ok) {
          throw new Error("Không thể tải sản phẩm");
        }

        const products = await response.json();

        // Xóa tin nhắn loading
        this.removeLastMessage();

        if (products.length === 0) {
          this.addMessage("Không có sản phẩm nào để hiển thị.", false);
          return;
        }

        // Sắp xếp tất cả sản phẩm theo giá từ thấp đến cao
        products.sort((a, b) => a.price - b.price);

        // Lấy top 5 sản phẩm giá rẻ nhất
        const topCheapProducts = products.slice(0, 5);

        // Hiển thị sản phẩm giá rẻ
        this.displayCheapProducts(topCheapProducts);
      } catch (error) {
        console.error("Lỗi khi tải sản phẩm:", error);
        this.removeLastMessage();
        this.addMessage(
          "Xin lỗi, không thể tải danh sách sản phẩm. Vui lòng thử lại sau.",
          false
        );
      }
    }

    // Hiển thị danh sách sản phẩm dạng grid nhỏ
    displayProducts(products) {
      if (!this.chatBody || !products || products.length === 0) {
        this.addMessage("Không có sản phẩm nào để hiển thị.", false);
        return;
      }

      const productsDiv = document.createElement("div");
      productsDiv.style.display = "flex";
      productsDiv.style.width = "100%";
      productsDiv.style.marginBottom = "0.5rem";
      productsDiv.style.justifyContent = "flex-start";

      const productsContainer = document.createElement("div");
      productsContainer.className = "bg-gray-100 rounded-lg p-3 max-w-full";
      productsContainer.style.maxHeight = "300px";
      productsContainer.style.overflowY = "auto";

      // Tiêu đề và thanh tìm kiếm
      const headerDiv = document.createElement("div");
      headerDiv.className = "flex items-center justify-between mb-3";

      const title = document.createElement("h3");
      title.className = "text-sm font-semibold text-gray-800";
      title.textContent =
        "📦 Danh sách sản phẩm (" + products.length + " sản phẩm)";

      const searchInput = document.createElement("input");
      searchInput.type = "text";
      searchInput.placeholder = "🔍 Tìm sản phẩm...";
      searchInput.className =
        "px-2 py-1 text-xs border border-gray-300 rounded-md focus:outline-none focus:border-primary";
      searchInput.style.width = "150px";
      searchInput.oninput = (e) =>
        this.filterProducts(e.target.value, products, grid);

      headerDiv.appendChild(title);
      headerDiv.appendChild(searchInput);
      productsContainer.appendChild(headerDiv);

      // Grid sản phẩm
      const grid = document.createElement("div");
      grid.className = "grid grid-cols-2 gap-2";
      grid.style.maxWidth = "500px";
      grid.id = "products-grid";

      products.forEach((product) => {
        const productCard = this.createProductCard(product);
        grid.appendChild(productCard);
      });

      productsContainer.appendChild(grid);
      productsDiv.appendChild(productsContainer);
      this.chatBody.appendChild(productsDiv);
      this.scrollToBottom();
    }

    // Hiển thị sản phẩm giá rẻ nhất
    displayCheapProducts(cheapProducts) {
      if (!this.chatBody || !cheapProducts || cheapProducts.length === 0) {
        this.addMessage("Không có sản phẩm nào để hiển thị.", false);
        return;
      }

      const productsDiv = document.createElement("div");
      productsDiv.style.display = "flex";
      productsDiv.style.width = "100%";
      productsDiv.style.marginBottom = "0.5rem";
      productsDiv.style.justifyContent = "flex-start";

      const productsContainer = document.createElement("div");
      productsContainer.className =
        "bg-primary/10 rounded-lg p-3 max-w-full border border-primary/20";
      productsContainer.style.maxHeight = "400px";
      productsContainer.style.overflowY = "auto";

      // Tiêu đề
      const headerDiv = document.createElement("div");
      headerDiv.className = "mb-3";

      const title = document.createElement("h3");
      title.className = "text-sm font-semibold text-primary";
      title.textContent =
        "💰 Top " + cheapProducts.length + " Sản Phẩm Giá Rẻ Nhất";

      const subtitle = document.createElement("p");
      subtitle.className = "text-xs text-primary/80 mt-1";
      subtitle.textContent = "Được sắp xếp theo giá từ thấp đến cao";

      // Thêm thông tin về khoảng giá
      const priceRange = document.createElement("p");
      priceRange.className = "text-xs text-primary/80 mt-1";
      const minPrice =
        cheapProducts[0].formattedPrice ||
        this.formatPrice(cheapProducts[0].price) + "đ";
      const maxPrice =
        cheapProducts[cheapProducts.length - 1].formattedPrice ||
        this.formatPrice(cheapProducts[cheapProducts.length - 1].price) + "đ";
      priceRange.textContent = `Khoảng giá: ${minPrice} - ${maxPrice}`;

      headerDiv.appendChild(title);
      headerDiv.appendChild(subtitle);
      headerDiv.appendChild(priceRange);
      productsContainer.appendChild(headerDiv);

      // Danh sách sản phẩm giá rẻ
      const productsList = document.createElement("div");
      productsList.className = "space-y-2";

      cheapProducts.forEach((product, index) => {
        const productItem = this.createCheapProductItem(product, index + 1);
        productsList.appendChild(productItem);
      });

      productsContainer.appendChild(productsList);
      productsDiv.appendChild(productsContainer);
      this.chatBody.appendChild(productsDiv);
      this.scrollToBottom();
    }

    // Tạo card sản phẩm nhỏ
    createProductCard(product) {
      const card = document.createElement("div");
      card.className =
        "bg-white rounded-lg p-2 border border-gray-200 hover:shadow-md transition-shadow cursor-pointer";
      card.onclick = () => this.showProductDetail(product);

      // Ảnh sản phẩm
      const image = document.createElement("img");
      image.src =
        product.imageUrl ||
        window.location.pathname.replace("/index.jsp", "") +
          "/public/assets/images/product-placeholder.svg";
      image.alt = product.name;
      image.className = "w-full h-16 object-cover rounded-md mb-2";
      image.style.minHeight = "64px";

      // Tên sản phẩm
      const name = document.createElement("div");
      name.className = "text-xs font-medium text-gray-800 mb-1 line-clamp-2";
      name.textContent = product.name;
      name.style.display = "-webkit-box";
      name.style.webkitLineClamp = "2";
      name.style.webkitBoxOrient = "vertical";
      name.style.overflow = "hidden";

      // Giá
      const price = document.createElement("div");
      price.className = "text-xs font-bold text-primary";
      price.textContent =
        product.formattedPrice || this.formatPrice(product.price) + "đ";

      card.appendChild(image);
      card.appendChild(name);
      card.appendChild(price);

      return card;
    }

    // Tạo item sản phẩm giá rẻ
    createCheapProductItem(product, rank) {
      const item = document.createElement("div");
      item.className =
        "bg-white rounded-lg p-3 border border-primary/20 hover:shadow-md transition-shadow cursor-pointer";
      item.onclick = () => this.showProductDetail(product);

      // Container chính
      const mainDiv = document.createElement("div");
      mainDiv.className = "flex items-center gap-3";

      // Rank badge
      const rankBadge = document.createElement("div");
      rankBadge.className =
        "flex-shrink-0 w-8 h-8 bg-primary text-white rounded-full flex items-center justify-center text-xs font-bold";
      rankBadge.textContent = rank;

      // Ảnh sản phẩm
      const image = document.createElement("img");
      image.src =
        product.imageUrl ||
        window.location.pathname.replace("/index.jsp", "") +
          "/public/assets/images/product-placeholder.svg";
      image.alt = product.name;
      image.className = "w-16 h-16 object-cover rounded-md flex-shrink-0";

      // Thông tin sản phẩm
      const infoDiv = document.createElement("div");
      infoDiv.className = "flex-1 min-w-0";

      const name = document.createElement("div");
      name.className = "text-sm font-semibold text-gray-800 mb-1 line-clamp-2";
      name.textContent = product.name;
      name.style.display = "-webkit-box";
      name.style.webkitLineClamp = "2";
      name.style.webkitBoxOrient = "vertical";
      name.style.overflow = "hidden";

      const price = document.createElement("div");
      price.className = "text-sm font-bold text-primary";
      price.textContent =
        product.formattedPrice || this.formatPrice(product.price) + "đ";

      const viewButton = document.createElement("button");
      viewButton.className =
        "mt-2 px-3 py-1 bg-primary text-white text-xs rounded hover:bg-primary/90 transition-colors";
      viewButton.textContent = "Xem chi tiết";
      viewButton.onclick = (e) => {
        e.stopPropagation();
        this.showProductDetail(product);
      };

      infoDiv.appendChild(name);
      infoDiv.appendChild(price);
      infoDiv.appendChild(viewButton);

      mainDiv.appendChild(rankBadge);
      mainDiv.appendChild(image);
      mainDiv.appendChild(infoDiv);

      item.appendChild(mainDiv);
      return item;
    }

    // Hiển thị chi tiết sản phẩm
    showProductDetail(product) {
      const detailDiv = document.createElement("div");
      detailDiv.style.display = "flex";
      detailDiv.style.width = "100%";
      detailDiv.style.marginBottom = "0.5rem";
      detailDiv.style.justifyContent = "flex-start";

      const detailContainer = document.createElement("div");
      detailContainer.className =
        "bg-blue-50 rounded-lg p-3 max-w-full border border-blue-200";

      // Tạo HTML content một cách an toàn
      const imageSrc =
        product.imageUrl ||
        window.location.pathname.replace("/index.jsp", "") +
          "/public/assets/images/product-placeholder.svg";
      const productUrl =
        window.location.pathname.replace("/index.jsp", "") +
        "product?id=" +
        product.id;
      const productPrice =
        product.formattedPrice || this.formatPrice(product.price) + "đ";
      const productDesc = product.description || "Không có mô tả";

      detailContainer.innerHTML =
        '<div class="flex items-start gap-3">' +
        '<img src="' +
        imageSrc +
        '" ' +
        'alt="' +
        product.name +
        '" ' +
        'class="w-16 h-16 object-cover rounded-md flex-shrink-0">' +
        '<div class="flex-1 min-w-0">' +
        '<h4 class="text-sm font-semibold text-gray-800 mb-1">' +
        product.name +
        "</h4>" +
        '<p class="text-xs text-gray-600 mb-2 line-clamp-2">' +
        productDesc +
        "</p>" +
        '<div class="text-sm font-bold text-primary mb-2">' +
        productPrice +
        "</div>" +
        "<button onclick=\"window.open('" +
        productUrl +
        "', '_blank')\" " +
        'class="px-3 py-1 bg-primary text-white text-xs rounded hover:bg-primary/90 transition-colors">' +
        "Xem chi tiết" +
        "</button>" +
        "</div>" +
        "</div>";

      detailDiv.appendChild(detailContainer);
      this.chatBody.appendChild(detailDiv);
      this.scrollToBottom();
    }

    // Format giá tiền
    formatPrice(price) {
      if (!price) return "0";
      return new Intl.NumberFormat("vi-VN").format(price);
    }

    // Xóa tin nhắn cuối cùng
    removeLastMessage() {
      if (this.chatBody && this.chatBody.lastElementChild) {
        this.chatBody.removeChild(this.chatBody.lastElementChild);
      }
    }

    // Lọc sản phẩm theo từ khóa tìm kiếm
    filterProducts(searchTerm, allProducts, gridElement) {
      if (!gridElement) return;

      const filteredProducts = allProducts.filter(
        (product) =>
          product.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
          (product.description &&
            product.description
              .toLowerCase()
              .includes(searchTerm.toLowerCase()))
      );

      // Xóa grid cũ
      gridElement.innerHTML = "";

      // Hiển thị sản phẩm đã lọc
      if (filteredProducts.length === 0) {
        const noResults = document.createElement("div");
        noResults.className =
          "col-span-2 text-center text-gray-500 text-xs py-4";
        noResults.textContent = "Không tìm thấy sản phẩm nào";
        gridElement.appendChild(noResults);
      } else {
        filteredProducts.forEach((product) => {
          const productCard = this.createProductCard(product);
          gridElement.appendChild(productCard);
        });
      }
    }
  }

  // Khởi tạo chatbot khi DOM sẵn sàng
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", () => {
      new ChatBot();
    });
  } else {
    // DOM đã sẵn sàng
    new ChatBot();
  }
</script>
