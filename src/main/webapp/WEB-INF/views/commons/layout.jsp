<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<html>
  <head>
    <title><tiles:getAsString name="title"/></title>
    <style>
    	.container {
    		margin-top: 10px;
    	}
    	.container.footer {
    		width: 100%;
    	}
    </style>
  </head>
  <body>
  		<div class="container">
  			<tiles:insertAttribute name="header" />
  		</div>
  		<div class="container">
  			<tiles:insertAttribute name="body" />
  		</div>
  		<div class="container footer" >
  			<tiles:insertAttribute name="footer" />
  		</div>
  </body>
</html>