<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="p-4 w-full border-b border-muted flex items-center justify-between gap-4 fixed bg-background">
    <div class="flex-1">
        <a href="${pageContext.request.contextPath}">
            <img class="w-56" src="./public/assets/images/logo/logo-primary.svg" alt="Logo"/>
        </a>
    </div>
    <div class="flex-1 flex justify-end items-center gap-4">
        <a href="${pageContext.request.contextPath}">
            <button class="px-4 py-2 has-[>svg]:px-3 cursor-pointer border bg-background shadow-xs hover:bg-accent hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive text-sm">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-left-icon lucide-chevron-left"><path d="m15 18-6-6 6-6"/></svg>
                Trở về trang chủ
            </button>
        </a>
    </div>
</div>