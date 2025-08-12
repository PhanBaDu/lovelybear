<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="p-4 w-full border-b border-muted flex items-center justify-between gap-4">
    <div class="flex-1">
        <a href="${pageContext.request.contextPath}">
            <img class="w-56" src="./public/assets/images/logo/logo-primary.svg" alt="Logo"/>
        </a>
    </div>
    <div class="flex-1 relative">
        <input placeholder="Tìm kiếm một sản phẩm mà bạn mong muốn..." class="file:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 w-full min-w-0 rounded-md border bg-transparent px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm" />
        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"  stroke-linejoin="round" class="absolute right-2 -top-[3px] w-5 h-5 translate-y-2/4 lucide lucide-search-icon lucide-search text-muted-foreground"><path d="m21 21-4.34-4.34"/><circle cx="11" cy="11" r="8"/></svg>
    </div>
    <div class="flex-1 flex justify-end items-center gap-4">
        <a href="signup">
        <button class="w-36 h-9 px-4 py-2 has-[>svg]:px-3 cursor-pointer bg-secondary text-secondary-foreground shadow-xs hover:bg-secondary/80 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive">Đăng ký</button>
        </a>
        <a href="signin">
            <button class="w-36 h-9 px-4 py-2 has-[>svg]:px-3 cursor-pointer bg-primary text-primary-foreground shadow-xs hover:bg-primary/90 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive">Đăng nhập</button>
        </a>
    </div>
</div>