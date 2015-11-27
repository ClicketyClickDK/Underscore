function linkMe(link) {
    url = link.replace (/\.[\.]*$/, '')
    url += '.html'
    document.write("<a href='" + url + "' title='Jump to HELP on [" + link + "]'>" + link + "</a>")
}
