up.compiler('.layout', function() {
    $layout_side = $(this).find('.layout--side')
    $layout_main = $(this).find('.layout--main')
    $layout_cover = $(this).find('.layout--cover')
    $layout_toggle = $(this).find('.layout--toggle')

    function closeSidebar(){
        $layout_side.removeClass('-sidebar-toggle')
        $layout_main.removeClass('-sidebar-toggle')
        $layout_cover.removeClass('-sidebar-toggle')
        $layout_toggle.removeClass('-sidebar-toggle')
    }

    function toggleSidebar(){
        $layout_side.toggleClass('-sidebar-toggle')
        $layout_main.toggleClass('-sidebar-toggle')
        $layout_cover.toggleClass('-sidebar-toggle')
        $layout_toggle.toggleClass('-sidebar-toggle')
    }

    $layout_toggle.click(function(){
        toggleSidebar()
    })

    $layout_cover.click(function(){
        closeSidebar()
    })

    $(this).find('.sidebar--item').click(function(){
        closeSidebar()
    })
})

$(document).ready(function(){
    window.setInterval(function(){
        up.replace('.layout--dummy', window.location, {cache: false})
    }, 5000);
})
