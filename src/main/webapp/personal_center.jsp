<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>个人中心</title>
<%@include file="common.jsp"%>
<style>
.admin {
	padding: 30px;
	background: #fff;
	border-left: solid 1px #b5cfd9;
	overflow: auto;
}

.radio .sex-man.active {
	color: white;
	background-color: #0ae;
}

.radio .sex-woman.active {
	color: white;
	background-color: #f60;
}
</style>
</head>
<body>
	<jsp:include page="nav.jsp"></jsp:include>
	<%--     <%@include file="nav.jsp" %> --%>
	<div class="container">
		<div class="admin">
			<div class="line-big">
				<div class="xm3">
					<div class="panel border-back">
						<div class="panel-body text-center">
							<img src="<%=current_user.getString("HEADPHOTO")%>" width="120"
								class="radius-circle"> <br>
							<%=current_user.getString("USERNAME")%>
						</div>
						<div class="panel-foot bg-back border-back">
							您好，<span class="realname"><%=current_user.getString("REALNAME")%></span>
							<%
								if ((Integer) current_user.get("SEX") == 1) {
							%>先生，
							<%
								} else {
							%>女士,
							<%
								}
							%>
							这是您第100次登录，上次登录为2014-10-1。
						</div>
					</div>
					<br>
					<!-- 					<div class="panel"> -->
					<!-- 						<div class="panel-head"> -->
					<!-- 							<strong>站点统计</strong> -->
					<!-- 						</div> -->
					<!-- 						<ul class="list-group"> -->
					<!-- 							<li><span class="float-right badge bg-red">88</span><span -->
					<!-- 								class="icon-user"></span> 会员</li> -->
					<!-- 							<li><span class="float-right badge bg-main">828</span><span -->
					<!-- 								class="icon-file"></span> 文件</li> -->
					<!-- 							<li><span class="float-right badge bg-main">828</span><span -->
					<!-- 								class="icon-shopping-cart"></span> 订单</li> -->
					<!-- 							<li><span class="float-right badge bg-main">828</span><span -->
					<!-- 								class="icon-file-text"></span> 内容</li> -->
					<!-- 							<li><span class="float-right badge bg-main">828</span><span -->
					<!-- 								class="icon-database"></span> 数据库</li> -->
					<!-- 						</ul> -->
					<!-- 					</div> -->
					<br>
				</div>
				<div class="xm9">
					<div class="alert alert-yellow">
						<span class="close"></span><strong>注意：</strong>您有5条未读信息，<a
							href="#">点击查看</a>。
					</div>
					<div class="alert">
						<!-- 						<h4>拼图前端框架介绍</h4> -->
						<!-- 						<p class="text-gray padding-top">拼图是优秀的响应式前端CSS框架，国内前端框架先驱及领导者，自动适应手机、平板、电脑等设备，让前端开发像游戏般快乐、简单、灵活、便捷。</p> -->
						<div class="media-inline clearfix">
							<div class="media media-y x3">
								<a href="#"><span class="icon-cny text-large"></span> <span
									class="badge bg-red">88.00</span></a>
								<div class="media-body">
									<strong>我的余额</strong>
								</div>
							</div>
							<div class="media media-y x3">
								<a href="#"><span class="icon-envelope-o text-large"></span>
									<span class="badge bg-yellow">5</span></a>
								<div class="media-body">
									<strong>我的信息</strong>
								</div>
							</div>
							<div class="media media-y x3">
								<a href="#"><span class="icon-heart text-large"></span> <span
									class="badge bg-red">3</span></a>
								<div class="media-body">
									<strong>我的收藏</strong>
								</div>
							</div>
							<div class="media media-y x3">
								<a href="logout.do"><span
									class="icon-sign-out text-red text-large"></span></a>
								<div class="media-body">
									<strong>退出</strong>
								</div>
							</div>
						</div>
					</div>
					<div class="panel">
						<div class="panel-head">
							<strong>个人信息</strong>
							<button
								class="btn-info-edit button border-main icon-edit float-right">
								编辑</button>
							<button
								class="btn-info-save button border-main icon-save float-right"
								style="display: none;">保存</button>
						</div>
						<form id="infoForm" class="form-x">
							<input type="hidden" name="USER_ID"
								value="<%=current_user.getString("USER_ID")%>">
							<!-- 							<input -->
							<!-- 								type="text" class="input" name="SEX" -->
							<%-- 								value="<%=(Integer)current_user.get("SEX")%>" /> --%>
							<div class="panel-body">
								<div id="info-enable" style="display: none;">
									<div class="form-group">
										<div class="label">
											<label for="password">密码</label>
										</div>
										<div class="field">
											<input type="text" class="input" id="password"
												name="PASSWORD"
												value="<%=current_user.getString("PASSWORD")%>">
										</div>
									</div>
									<div class="form-group">
										<div class="label">
											<label for="realname">真实姓名</label>
										</div>
										<div class="field">
											<input type="text" class="input" id="realname"
												name="REALNAME"
												value="<%=current_user.getString("REALNAME")%>">
										</div>
									</div>
									<div class="form-group">
										<div class="label">
											<label for="sex">性别</label>
										</div>
										<div class="field">
											<div class="button-group radio">
												<%
													if ((Integer) current_user.get("SEX") == 1) {
												%>
												<label class="button border-sub sex-man active"> <input
													name="SEX" value="1" type="radio" checked="checked">男性
												</label> <label class="button border-yellow sex-woman"> <input
													name="SEX" value="0" type="radio">女性
												</label>
												<%
													} else {
												%>
												<label class="button border-sub sex-man active"> <input
													name="SEX" value="1" type="radio">男性
												</label> <label class="button border-yellow sex-woman"> <input
													name="SEX" value="0" type="radio" checked="checked">女性
												</label>
												<%
													}
												%>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="label">
											<label for="phone">手机号码</label>
										</div>
										<div class="field">
											<input type="text" class="input" id="phone" name="PHONE"
												value="<%=current_user.getString("PHONE")%>">
										</div>
									</div>
									<div class="form-group">
										<div class="label">
											<label for="address">地址</label>
										</div>
										<div class="field">
											<input type="text" class="input" id="address" name="ADDRESS"
												value="<%=current_user.getString("ADDRESS")%>">
										</div>
									</div>
								</div>

								<table class="table" id="info-disable">
									<tbody>
										<tr>
											<td width="110" align="right">用户名:</td>
											<td class="username"><%=current_user.getString("USERNAME")%></td>
											<td width="90" align="right">密码:</td>
											<td class="password"><%=current_user.getString("PASSWORD")%></td>
										</tr>
										<tr>
											<td align="right">真实姓名:</td>
											<td class="realname"><%=current_user.getString("REALNAME")%></td>
											<td align="right">性别:</td>
											<td class="sex">
												<%
													if ((Integer) current_user.get("SEX") == 1) {
														out.print("男性");
													} else {
														out.print("女性");
													}
												%>
											</td>
										</tr>
										<tr>
											<td align="right">手机号码:</td>
											<td class="phone"><%=current_user.getString("PHONE")%></td>
											<td align="right">地址:</td>
											<td class="address"><%=current_user.getString("ADDRESS")%></td>
										</tr>
									</tbody>
								</table>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="layout">
		<div class="line">
			<div class="mobile  xl12 xs12 hidden-b hidden-m"
				style="padding-bottom: 50px;">
				<%--<div class="head-fix fixed bg-green bg-inverse x12" data-style="fixed-top" data-offset-fixed="0" style="z-index: 1">--%>
				<div class="head-fix bg-green bg-inverse x12">
					<span>我的</span> <a class="btn-config icon icon-cog float-right"></a>
					<a class="icon icon-bell float-right"></a>
				</div>
				<a class="personal_info bg-green bg-inverse xl12"
					href="personal/personal_info.jsp"> <span class="xl3"> <img
						class="personal-photo  radius-circle" src="images/user/face.jpg"
						alt="">
				</span> <span class="xl5 padding">
						<p class="text-big">19211470762</p>
						<p>
							<span
								class="icon icon-mobile-phone text-large margin-small-right"></span>19211470762
						</p>
				</span> <span class="icon icon-chevron-right text-large float-right"></span>
				</a>

				<div class="bg-white xl12 hidden-s hidden-m"
					style="height: 70px; line-height: 70px;">
					<div class="xl4 text-center"
						style="height: 100%; padding-top: 10px;">
						<p class="text-red" style="margin: 0;">
							<span class="text-large margin-right">0.0</span>元
						</p>

						<p style="margin: 0;">我的余额</p>
					</div>
					<div class="xl4 text-center"
						style="height: 100%; padding-top: 10px;">
						<p class="text-red" style="margin: 0;">
							<span class="text-large margin-right">0</span>个
						</p>

						<p style="margin: 0;">我的红包</p>
					</div>
					<div class="xl4 text-center"
						style="height: 100%; padding-top: 10px;">
						<p class="text-red" style="margin: 0;">
							<span class="text-large margin-right">0</span>积分
						</p>

						<p style="margin: 0;">我的积分
					</div>
				</div>

				<div class="x12">
					<a class="bg-white x12 xl12 height-large margin-top"> <span
						class="icon-heart text-red text-big margin-big"></span>我的收藏
					</a> <a class="bg-white x12 xl12 height-large margin-top"> <span
						class="icon-photo text-blue text-big margin-big"></span>我的收藏
					</a>
				</div>
			</div>

			<div class="fixed-bottom border xl12 hidden-s hidden-m hidden-b"
				id="bottom-nav"
				style="width: 100%; background: #efefef; z-index: 1;">
				<ul
					class="nav nav-menu nav-inline nav-justified text-center text-gray">
					<li class="xl4"><a href="index" class="text-gray">
							<div class="icon-home text-large"></div> 订餐
					</a></li>
					<li class="xl4"><a href="#" class="text-gray">
							<div class="icon-list text-large"></div> 订单
					</a></li>
					<li class="xl4"><a href="personal_center"
						class="text-gray text-main">
							<div class="icon-user text-large"></div> 我的
					</a></li>
				</ul>
			</div>
		</div>
	</div>

	<script>
		$(function() {
			$(".btn-info-edit").on("click", function() {
				$("#info-disable").hide();
				$("#info-enable").show();
				$(".btn-info-edit").hide();
				$(".btn-info-save").show();
			})
			$(".btn-info-save").on("click", function() {
				$.ajax({
					url : "user/edit.do",
					type : "post",
					data : $("#infoForm").serialize(),
					dataType : "html",
					timeput : "10000"
				}).done(function(data) {
					var data = eval('(' + data + ')');
					if (data.msg == 'success') {
						$("#info-enable").hide();
						$("#info-disable").show();
						$(".btn-info-save").hide();
						$(".btn-info-edit").show();
						$("#info-disable .password").text(data.user.PASSWORD);
						$(".realname").text(data.user.REALNAME);
						if (data.user.SEX == 1) {
							$("#info-disable .sex").text("男性");
						} else {
							$("#info-disable .sex").text("女性");
						}
						$("#info-disable .phone").text(data.user.PHONE);
						$("#info-disable .address").text(data.user.ADDRESS);
					} else {
						layer.msg("信息修改失败！", {
							icon : 7
						});
					}
				}).error(function() {
					layer.msg("信息修改请求失败！", {
						icon : 7
					});
				});
			})
		})
	</script>
</body>
</html>
