<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.9.0.js"></script>

<style type="text/css">
.blog-content-header {
border-bottom:1px solid #e6e6e6;
width:100%;
overflow:hidden;
}
.blog-content-header h2 {
float:left;
width:75%;
padding:0px;
margin:0px;
overflow:hidden;
}
.blog-content-header div {
float:right;
width:25%;
height:35px;
line-height:35px;
font-size:15px;
text-align:right;
padding:0px;
margin:0px;
overflow:hidden;
}
.blog-content-url {
font-size:12px;
text-align:right;
width:100%;
padding:5px 0 5px 0;
margin:0px;
overflow:hidden;
}
.blog-content-url a {
text-decoration:none;
color:#cccccc;
font-weight:normal;
}
.blog-content-url a:hover {
text-decoration:underline;
}
.blog-list-h {
height:40px;
line-height:40px;
font-weight:bold;
color:#636363;
border-top:1px solid #b1b1b1;
border-bottom:1px solid #b1b1b1;
padding:0px;
margin:0px;
overflow:hidden;
}
.border-content-bottom {
width:100%;
text-align:right;
overflow:hidden;
}
.border-content-bottom a {
color:#676767;
font-size:12px;
font-weight:bold;
text-decoration:none;
}

/*
	게시판 리스트 페이징
*/
div.pager {
	width:100%;
	text-align:center;
	margin-bottom:15px;
	overflow:hidden;
}
div.pager  ul {
	height:20px;
	margin:10px auto;
}
div.pager  ul li 			{ color:#ddd; display:inline-block; margin:5px 0; width:20px ; font-weight:bold; }
div.pager  ul li.selected	{ font-size:16px; text-decoration: underline; color:#f40808 }
div.pager  ul li a,
div.pager  ul li a:visited,
div.pager  ul li a:link,
div.pager  ul li a:active	{ text-decoration: none; color:#555 }
div.pager  ul li a:hover	{ text-decoration: none; color:#f00 }
</style>


<script type="text/javascript">
//다이어로그
function dialog(msgs, urls) {
  var retVal = confirm(msgs);
   if(retVal == true){
      location.href=urls;
   }
}

function pagingRefresh(pages, categoryNo, blogId) {
	//alert("ddd");
	/* ajax 통신 */
	$.ajax({
		url: "${pageContext.servletContext.contextPath}/blog/admin/api/postPaging",
		type: "post",
		dataType: "json",
		data: {
			'pages':pages,
			'categoryNo':categoryNo,
			'blogId':blogId
		},
		success: function(response){
			if(response.result != "success") {
				alert(response.message);
				return;
			}
			
			//페이징 부분 만들기
			var htmls = "";
			var pagingMap = response.data.pagingMap;
			htmls = '<ul>';
			if((pagingMap.rangeStart-1) < 1)
				htmls += '	<li>◀</li>';
			if((pagingMap.rangeStart-1) >= 1) {
				if('${hasCategory}' == 'false')
					htmls += '	<li><a href="#100" onclick="pagingRefresh('+(pagingMap.rangeStart - 1)+',-1,\'${blogVo.blogId}\')">◀</a></li>';
				else
					htmls += '	<li><a href="#100" onclick="pagingRefresh('+(pagingMap.rangeStart - 1)+',${mainPostVo.categoryNo},\'${blogVo.blogId}\')">◀</a></li>';
			}
			var i = 0;
			for(i=pagingMap.rangeStart;i<=(pagingMap.rangeStart + pagingMap.pageCnt - 1);i++) {
				if(i > pagingMap.lastPage)
					htmls += '<li>'+i+'</li>';
				if(i <= pagingMap.lastPage) {
					if(i == pagingMap.pages)
						htmls += '<li class="selected">'+i+'</li>';
					else {
						if('${hasCategory}' == 'false')
							htmls += '<li><a href="#100" onclick="pagingRefresh('+i+',-1,\'${blogVo.blogId}\');">'+i+'</a></li>';
						else
							htmls += '<li><a href="#100" onclick="pagingRefresh('+i+',${mainPostVo.categoryNo},\'${blogVo.blogId}\');">'+i+'</a></li>';
					}
				}
			}
			if((pagingMap.rangeStart + pagingMap.pageCnt) <= pagingMap.lastPage) {
				if('${hasCategory}' == 'false')
					htmls += '<li><a href="#100" onclick="pagingRefresh('+(pagingMap.rangeStart + pagingMap.pageCnt)+',-1,\'${blogVo.blogId}\')">▶</a></li>';
				else
					htmls += '<li><a href="#100" onclick="pagingRefresh('+(pagingMap.rangeStart + pagingMap.pageCnt)+',${mainPostVo.categoryNo},\'${blogVo.blogId}\')">▶</a></li>';
			}
			if((pagingMap.rangeStart + pagingMap.pageCnt) >= pagingMap.lastPage)
				htmls += '<li>▶</li>';
				
			htmls += '</ul>';
			
			document.getElementById("pager_bk").innerHTML = htmls;
			

			
			//리스트 부분 만들기
			htmls = "";
			var postList = response.data.postList;
			var mainPostVo = '${mainPostVo}';
			for(i=0;i<postList.length;i++) {
				var plist = postList[i];
				htmls +=	'<li>';
				htmls +=	'<a href="${pageContext.request.contextPath}/${blogVo.blogId}/'+plist.categoryNo+'/'+plist.no+'" ';
				if(mainPostVo != '' && '${mainPostVo.no}' == plist.no) {
					htmls += 'style="color:red;"';
				}
				htmls +=	'>';
				htmls +=	'	['+plist.categoryName+'] '+plist.title;
				htmls +=	'</a>';
				htmls +=	'<span>'+plist.regDate+'</span>';
				htmls +=	'</li>';
			}

			document.getElementById("blog_list_bk").innerHTML = htmls;
			
		},
		error: function(xhr, error){
			console.error("error:" + error);
		}
	});
	
	
}
</script>


</head>
<body>
	<div id="container">
		<div id="header">
			<h1><a href="${pageContext.request.contextPath}/${blogVo.blogId}" style="color:#ffffff;">${blogVo.title}</a></h1>
			<c:import url="/WEB-INF/views/includes/blog-navigation.jsp"></c:import>
		</div>
		<div id="wrapper">
			<div id="content">
				<c:if test="${mainPostVo eq null}">
				<div class="blog-content">
					<h2 style="width:100%;text-align:center;padding:0px;margin-top:50px;">포스트가 없습니다</h2>
				</div>
				</c:if>
				<c:if test="${mainPostVo ne null}">
				<div class="blog-content">
					<div class="blog-content-header">
						<h2><span style="color:blue;">[${mainPostVo.categoryName}]</span> ${mainPostVo.title}</h2>
						<div>${mainPostVo.regDate}</div>
					</div>
					<div class="blog-content-url">
						<a href="${blogURL}/${blogVo.blogId}/${mainPostVo.categoryNo}/${mainPostVo.no}">${blogURL}/${blogVo.blogId}/${mainPostVo.categoryNo}/${mainPostVo.no}</a>
					</div>
					<p>
						${mainPostVo.content}
					<p>
					<c:if test="${authUser ne null}">
						<c:if test="${authUser.id eq blogVo.blogId}">
							<div class="border-content-bottom">
								<a href="${pageContext.request.contextPath}/${blogVo.blogId}/admin/${mainPostVo.categoryNo}/${mainPostVo.no}/postedit">수정하기</a>
								<a href="#100" onclick="dialog('정말로 삭제 하시겠습니까?','${pageContext.request.contextPath}/${blogVo.blogId}/admin/${mainPostVo.categoryNo}/${mainPostVo.no}/postdel');">삭제하기</a>
							</div>
						</c:if>
					</c:if>
				</div>
				<h3 class="blog-list-h">
					이 블로그 
					<c:if test="${hasCategory eq false}"><span style="color:#cf8b0c;">전체</span></c:if>
					<c:if test="${hasCategory eq true}"><span style="color:#cf8b0c;">${mainPostVo.categoryName}</span></c:if>
					 카테고리 글
					 <span style="color:#cf8b0c;">(${mainPostSize})</span>
				</h3>
				<ul class="blog-list" id="blog_list_bk">
					<c:forEach items="${mainPostList}" var="plist">
						<li>
							<a href="${pageContext.request.contextPath}/${blogVo.blogId}/${plist.categoryNo}/${plist.no}" >
								<c:if test="${mainPostVo ne null}">
								<c:if test="${mainPostVo.no eq plist.no}">
									<span style="color:red;">[${plist.categoryName}] ${plist.title}</span>
								</c:if>
								<c:if test="${mainPostVo.no ne plist.no}">
									[${plist.categoryName}] ${plist.title}
								</c:if>
								</c:if>
							</a>
							<span>${plist.regDate}</span>
						</li>
					</c:forEach>
				</ul>
				<!-- pager 추가 -->
				<div class="pager" id="pager_bk">
					<ul>
						<!-- 1보다 작으면 버튼 비활성화 -->
						<c:if test="${(pagingMap.rangeStart - 1) lt 1}">
							<li>◀</li>
						</c:if>
						<!-- 1보다 같거나 크면 버튼 활성화-->
						<c:if test="${(pagingMap.rangeStart - 1) ge 1}">
							<c:if test="${hasCategory eq false}">
								<li><a href="#100" onclick="pagingRefresh(${pagingMap.rangeStart - 1},-1,'${blogVo.blogId}')">◀</a></li>
							</c:if>
							<c:if test="${hasCategory eq true}">
								<li><a href="#100" onclick="pagingRefresh(${pagingMap.rangeStart - 1},${mainPostVo.categoryNo},'${blogVo.blogId}')">◀</a></li>
							</c:if>
						</c:if>
						<c:forEach begin="${pagingMap.rangeStart}" end="${pagingMap.rangeStart + pagingMap.pageCnt - 1}" var="i">
							<!-- 최대 페이지를 넘어가면 비활성화 -->
							<c:if test="${i gt pagingMap.lastPage}">
								<li>${i}</li>
							</c:if>
							<c:if test="${i le pagingMap.lastPage}">
								<c:if test="${i eq pagingMap.pages}">
									<li class="selected">${i}</li>
								</c:if>
								<c:if test="${i ne pagingMap.pages}">
									<c:if test="${hasCategory eq false}">
									<li><a href="#100" onclick="pagingRefresh(${i},-1,'${blogVo.blogId}');">${i}</a></li>
									</c:if>
									<c:if test="${hasCategory eq true}">
									<li><a href="#100" onclick="pagingRefresh(${i},${mainPostVo.categoryNo},'${blogVo.blogId}');">${i}</a></li>
									</c:if>
								</c:if>
							</c:if>
						</c:forEach>
						<!-- 최대 페이지보다 작거나 같으면 버튼활성화 -->
						<c:if test="${(pagingMap.rangeStart + pagingMap.pageCnt) le pagingMap.lastPage}">
							<c:if test="${hasCategory eq false}">
								<li><a href="#100" onclick="pagingRefresh(${pagingMap.rangeStart + pagingMap.pageCnt},-1,'${blogVo.blogId}')">▶</a></li>
							</c:if>
							<c:if test="${hasCategory eq true}">
								<li><a href="#100" onclick="pagingRefresh(${pagingMap.rangeStart + pagingMap.pageCnt},${mainPostVo.categoryNo},'${blogVo.blogId}')">▶</a></li>
							</c:if>
						</c:if>
						<!-- 최대 페이지보다 크면 버튼 비활성화 -->
						<c:if test="${(pagingMap.rangeStart + pagingMap.pageCnt) gt pagingMap.lastPage}">
							<li>▶</li>
						</c:if>
							
					</ul>
				</div>					
				<!-- pager 추가 -->
				</c:if>
			</div>
		</div>

		<div id="extra" style="padding-top:10px;">
			<div class="blog-logo">
				<c:if test="${blogVo.logo eq null}">
					<img src="${pageContext.request.contextPath}/assets/images/spring-logo.jpg" style="width:180px;" />
				</c:if>
				<c:if test="${blogVo.logo ne null}">
					<img src="${pageContext.request.contextPath}/${blogVo.logo}" style="width:180px;" />
				</c:if>
			</div>
		</div>
		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
				<c:forEach items="${categoryList}" var="cdata">
					<li><a href="${pageContext.request.contextPath}/${blogVo.blogId}/${cdata.no}">${cdata.name}</a></li>
				</c:forEach>
			</ul>
		</div>
		
		<div id="footer">
			<p>
				<strong>${blogVo.title}</strong> is powered by JBlog (c)2016
			</p>
		</div>
	</div>
</body>
</html>