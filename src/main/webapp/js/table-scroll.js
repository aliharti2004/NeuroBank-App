// JavaScript to add scroll indicators and handle scroll events
document.addEventListener('DOMContentLoaded', function () {
    const tableSections = document.querySelectorAll('.section');

    tableSections.forEach(section => {
        const table = section.querySelector('table');

        if (table && table.scrollWidth > section.clientWidth) {
            // Add scrollable class to show hint
            section.classList.add('scrollable');
            section.classList.add('has-scroll');

            // Remove hint after first scroll
            section.addEventListener('scroll', function () {
                section.classList.add('scrolled');
                section.classList.remove('has-scroll');

                // Show/hide shadow based on scroll position
                if (section.scrollLeft + section.clientWidth >= section.scrollWidth - 10) {
                    section.classList.remove('has-scroll');
                } else {
                    section.classList.add('has-scroll');
                }
            }, { once: false });
        }
    });

    // Handle window resize
    window.addEventListener('resize', function () {
        tableSections.forEach(section => {
            const table = section.querySelector('table');
            if (table && table.scrollWidth > section.clientWidth) {
                section.classList.add('scrollable');
            } else {
                section.classList.remove('scrollable');
            }
        });
    });
});
