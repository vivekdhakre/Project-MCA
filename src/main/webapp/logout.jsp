<%
    session.removeAttribute("role");
    session.removeAttribute("user");
    session.invalidate();
    response.sendRedirect("login?logout");
%>