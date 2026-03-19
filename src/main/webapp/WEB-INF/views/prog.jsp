<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>스타일가이드</title>
	<!-- 스타일 가이드 css 경로 -->
	<link rel="stylesheet" href="./resources/assets/dist/css/bootstrap.min.css">
	<!-- datepicker css  수정 , 등록 페이지에만 -일감-->
	<link rel="stylesheet" href="./resources/js/common/datepicker/jquery-ui.css">
	<!-- datepicker css  수정 , 등록 페이지에만 -일감-->
	<link rel="stylesheet" href="./resources/css/template/prog.css">
	<script src="./resources/js/common/jquery-3.7.1.min.js"></script>
	<script src="./resources/assets/dist/js/bootstrap.bundle.min.js"></script>
	<!-- modify페이지에서만 로드 -->
	<script src="./resources/js/common/ckeditor4/ckeditor.js"></script>
	<script src="./resources/js/common/datepicker/jquery-ui.js"></script>
	<!-- modify페이지에서만 로드 -->
	<!-- datepicker lang -->
	<script src="./resources/js/common/datepicker/lang/datepicker-ko.js"></script>
	<!-- datepicker lang-->
	<script src="./resources/js/common/clipboard.min.js"></script>
	<script src="./resources/js/common/programGuide.js"></script>
</head>

<body>
	<div class="wrap">
		<!-- wrap -->
		<h1 class="text-center mb-sm-4 pb-sm-4">
			공통 UI 스타일가이드<small class="text-muted fs-6  version">(231229-학사관리)</small>
		</h1>
		<!-- menu -->
		<div class="menu" id="progMenu">
			<span id="menubtn">메뉴</span>
			<ul class="ul">
				<li class="li">
					<a href="#ui01" class="ui1">01.검색</a>
				</li>
				<li class="li">
					<a href="#ui02" class="ui2">02.첨부파일목록/등록</a>
				</li>
				<li class="li">
					<a href="#ui03" class="ui3">03.공통 수정(위키,서식...)</a>
				</li>
				<li class="li">
					<a href="#ui04" class="ui4">04.공통 가로형식 등록/수정(일감,포토 등)</a>
				</li>
				<li class="li">
					<a href="#ui05" class="ui5">05.공통폼 세로형식 수정/등록</a>
				</li>
				<li class="li">
					<a href="#ui06" class="ui6">06.일감상세</a>
				</li>
				<li class="li">
					<a href="#ui07" class="ui7">07.일감목록</a>
				</li>
				<li class="li">
					<a href="#ui08" class="ui8">08.커뮤니티</a>
				</li>
				<li class="li">
					<a href="#ui09" class="ui9">09.페이지네이션</a>
				</li>
				<li class="li">
					<a href="#ui10" class="ui10">10.캘린더</a>
				</li>
			
				<li class="li">
					<a href="#ui11" class="ui11">11.댓글</a>
				</li>
				<li class="li">
					<a href="#ui12" class="ui12">12.마이페이지(비밀번호인증)</a>
				</li>
				<li class="li">
					<a href="#ui13" class="ui13">13.사원권한관리(관리자)</a>
				</li>
				<li class="li">
					<a href="#ui14" class="ui14">14.프로젝트목록</a>
				</li>
				<li class="li">
					<a href="#ui15" class="ui15">15.프로젝트상세</a>
				</li>
				<li class="li">
					<a href="#ui16" class="ui16">16.포토공간목록</a>
				</li>
				<li class="li">
					<a href="#ui17" class="ui17">17.포토공간상세</a>
				</li>
				<li class="li">
					<a href="#ui18" class="ui18">18.alarm</a>
				</li>
				<li class="li">
					<a href="#ui19" class="ui19">19.</a>
				</li>
				<li class="li">
					<a href="#ui20" class="ui20">20.</a>
				</li>
			</ul>
		</div>
		<script>

			let menu = document.querySelector("#menubtn");
			let menuList = document.querySelector(".ul");

			menu.addEventListener("click", function (event) {

				if (!menuList.classList.contains("open")) {
					menuList.classList.add("open");
				} else {
					menuList.classList.remove("open");
				}
			});
		</script>
		<!-- menu -->

		<!-- section01 -->
		<div class="section prog" id="sc1">


			<!-- ui 03 smaple-->
			<div class="ui">
				<strong class="ui-tit p-4">sample</strong>

				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- form -->

						<!-- form -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->


		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 03 smaple-->




			<!-- ui 03 검색바-->
			<div class="ui" id="ui01">
				<strong class="ui-tit p-4">검색</strong>

				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- form -->
				<form id="submitForm" action="">
					<input type="hidden" name="page" /> <input type="hidden"
						name="searchType" value="${condition.searchType}" /> <input
						type="hidden" name="searchWord" value="${condition.searchWord}" />
				</form>
				<!-- form -->
				<!-- searchBar -->
				<div data-pg-role="searchUI" data-pg-target="#submitForm"
					class="searchBox d-flex justify-content-end">
					<!-- 입력용도 UI  -->
					<select class="me-1" name="">
						<!-- 프롬프트 옵션  value는 공백(whitespace) -->
						<option value="">전체</option>
						<option value="name">이름</option>
						<option value="address">주소</option>
					</select>
					<select class="me-1" name="">
						<option value="">전체</option>
						<option value="name">이름</option>
						<option value="address">주소</option>
					</select>
					<div class="fieldset flex">
						<input class="me-1" type="text" name="searchWord"
							data-pg-init-value="${condition.searchWord}" title="검색어를 입력해주세요"
							placeholder="검색어를 입력해주세요" />
						<button type="button" class="btn btn-primary"
							data-pg-role="searchBtn">검색</button>
					</div>

				</div>
				<!-- searchBar -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->


		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 03 검색바-->

			<!-- ui 05 첨부파일-->
			<div class="ui" id="ui02">
				<strong class="ui-tit p-4">첨부파일</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- ui : file list & upload  s -->
						<div class="addfile">
							<!-- file_list -->
							<ul class="fileList">
								<!-- pdf -->
								<li class="d-flex file-row align-items-center justify-content-between">
									<a href="" class="file_item d-flex align-items-center">
										<i class="icon close"><em class="sr-only">첨부파일삭제</em></i>
										<i class="icon pdf"><em class="sr-only">pdf파일</em></i>
										<span class="">
											<em class="file_name">대덕인재개발원 리뉴얼.pdf</em>
											<span class="tm d-flex"><i class="icon time"></i>2분 전</span>
										</span>
									</a>
									<span  class="file_size p-1 border border-dark-subtle fileSize">604KB</span>
								</li>
								<!-- pdf -->
								<!-- hangle -->
								<li class="d-flex file-row align-items-center justify-content-between">
									<a href="" class="file_item d-flex align-items-center">
										<i class="icon close"><em class="sr-only">첨부파일삭제</em></i>
										<i class="icon hangle"><em class="sr-only">한글파일</em></i>
										<span class="">
											<em class="file_name">대덕인재개발원 리뉴얼.hwp</em>
											<span class="tm d-flex"><i class="icon time"></i>2분 전</span>
										</span>
									</a>
									<span  class="file_size p-1 border border-dark-subtle fileSize">604KB</span>
								</li>
								<!-- hangle -->
								<!-- excel -->
								<li class="d-flex file-row align-items-center justify-content-between">
									<a href="" class="file_item d-flex align-items-center">
										<i class="icon close"><em class="sr-only">첨부파일삭제</em></i>
										<i class="icon xlsx"><em class="sr-only">엑셀파일</em></i>
										<span class="">
											<em class="file_name">대덕인재개발원 리뉴얼.xlsx</em>
											<span class="tm d-flex"><i class="icon time"></i>2분 전</span>
										</span>
									</a>
									<span  class="file_size p-1 border border-dark-subtle fileSize">604KB</span>
								</li>
								<!-- excel -->
								<!-- zip -->
								<li class="d-flex file-row align-items-center justify-content-between">
									<a href="" class="file_item d-flex align-items-center">
										<i class="icon close"><em class="sr-only">첨부파일삭제</em></i>
										<i class="icon zip"><em class="sr-only">zip파일</em></i>
										<span class="">
											<em class="file_name">대덕인재개발원 리뉴얼.zip</em>
											<span class="tm d-flex"><i class="icon time"></i>2분 전</span>
										</span>
									</a>
									<span  class="file_size p-1 border border-dark-subtle fileSize">604KB</span>
								</li>
								<!-- zip -->
								<!-- txt -->
								<li class="d-flex file-row align-items-center justify-content-between">
									<a href="" class="file_item d-flex align-items-center">
										<i class="icon close"><em class="sr-only">첨부파일삭제</em></i>
										<i class="icon txt"><em class="sr-only">텍스트 파일</em></i>
										<span class="">
											<em class="file_name">대덕인재개발원 리뉴얼.txt</em>
											<span class="tm d-flex"><i class="icon time"></i>2분 전</span>
										</span>
									</a>
									<span  class="file_size p-1 border border-dark-subtle fileSize">604KB</span>
								</li>
								<!-- txt -->
								<!-- ppt -->
								<li class="d-flex file-row align-items-center justify-content-between">
									<a href="" class="file_item d-flex align-items-center">
										<i class="icon close"><em class="sr-only">첨부파일삭제</em></i>
										<i class="icon ppt"><em class="sr-only">텍스트 파일</em></i>
										<span class="">
											<em class="file_name">대덕인재개발원 리뉴얼.ppt</em>
											<span class="tm d-flex"><i class="icon time"></i>2분 전</span>
										</span>
									</a>
									<span  class="file_size p-1 border border-dark-subtle fileSize">604KB</span>
								</li>
								<!-- txt -->
								<!-- word -->
								<li class="d-flex file-row align-items-center justify-content-between">
									<a href="" class="file_item d-flex align-items-center">
										<i class="icon close"><em class="sr-only">첨부파일삭제</em></i>
										<i class="icon word"><em class="sr-only">word 파일</em></i>
										<span class="">
											<em class="file_name">대덕인재개발원 리뉴얼.docx</em>
											<span class="tm d-flex"><i class="icon time"></i>2분 전</span>
										</span>
									</a>
									<span  class="file_size p-1 border border-dark-subtle fileSize">604KB</span>
								</li>
								<!-- word -->
							</ul>
							<!-- file_list -->
							<div class="input-group my-2">
								<input type="file" class="form-control" id="addFileInput" aria-describedby="addFileBtn" aria-label="Upload">
								<button class="btn btn-primary" type="button" id="addFileBtn">첨부</button>
							</div>
							<!-- ui : addfile e -->
						
						</div>
						<!-- ui : file list & upload :  e -->

						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
						<code data-clipboard-text="">
		<!-- Code Start -->


		<!-- Code END -->
						</code>
						</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 05 첨부파일 -->
		
		
			
			<!-- ui 03  기본 수정 공통 폼(위키,서식,자주묻는 질문, 공지사항)-->
			<div class="ui" id="ui03">
				<strong class="ui-tit p-4">기본 수정 공통 폼(위키,서식,자주묻는 질문, 공지사항)</strong>

				<div class="content">
					<div class="inner html">
							<!-- ui : s -->
							<!-- modify veiw -->
							<div class="view edit">
								<div class="view_inner">
									<div class="view-info">
										<strong class="view-tit d-flex align-items-center">
											<div class=" col-sm-1">
												<label for="" class="">제목</label>
											</div>
											<div class=" col-sm-11">
												<input type="text" class="form-control" placeholder="제목을입력해주세요">
											</div>
											
										</strong>
										<ul class="ul clearfix">
											<li>
												<span class="list-tit">작성자</span>
												<span>김태은(개발1팀)</span>
											</li>
											<li>
												<span class="list-tit">등록일</span>
												<span>2024.04.05</span>
											</li>
											<li>
												<span class="list-tit">수정일</span>
												<span>2024.04.04</span></li>
											</li>
											<!-- 프로젝트 상태값:
														<li><span class="">상태</span><span>신규</span></li>
														<li><span class="">상태</span><span>안정</span></li>
														<li><span class="">상태</span><span>긴급</span></li>
												-->
										</ul>
									</div>
									<div class="view_content" id="viewEdit" ></div>
									<!-- 첨부파일 -->
									<!-- 첨부파일 -->
									<script>
										let viewEdit = document.querySelector("#viewEdit")
										
										CKEDITOR.replace(viewEdit,{
											language: "ko",
										
										});
										
									</script>
								</div>

							</div>
							<!-- modify veiw -->
							<!-- button -->
							<div class="btn-box clearfix mt-4">
								<button class="btn btn-secondary">목록</button>
								<div class="right float-end">
									<!-- <button class="btn btn-danger">취소</button> -->
									<button class="btn btn-danger">삭제</button>
									<button class="btn btn-primary">수정</button>
								</div>
							</div>
							<!-- button -->
							<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->
		&lt;!-- modify veiw -->
		&lt;div class="view edit">
			&lt;div class="view_inner">
				&lt;div class="view-info">
					&lt;strong class="view-tit d-flex align-items-center">
						&lt;div class=" col-sm-1">
							&lt;label for="" class="">제목&lt;/label>
						&lt;/div>
						&lt;div class=" col-sm-11">
							&lt;input type="text" class="form-control" placeholder="제목을입력해주세요">
						&lt;/div>
						
					&lt;/strong>
					&lt;ul class="ul clearfix">
						&lt;li>
							&lt;span class="list-tit">작성자&lt;/span>
							&lt;span>김태은(개발1팀)&lt;/span>
						&lt;/li>
						&lt;li>
							&lt;span class="list-tit">등록일&lt;/span>
							&lt;span>2024.04.05&lt;/span>
						&lt;/li>
						&lt;li>
							&lt;span class="list-tit">수정일&lt;/span>
							&lt;span>2024.04.04&lt;/span>&lt;/li>
						&lt;/li>
						&lt;!-- 프로젝트 상태값:
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>신규&lt;/span>&lt;/li>
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>안정&lt;/span>&lt;/li>
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>긴급&lt;/span>&lt;/li>
							-->
					&lt;/ul>
				&lt;/div>
				&lt;div class="view_content" id="viewEdit" >&lt;/div>
				&lt;!-- 첨부파일 -->
				&lt;!-- 첨부파일 -->
				&lt;script>
					let viewEdit = document.querySelector("#viewEdit")
					
					CKEDITOR.replace(viewEdit,{
						language: "ko",
					
					});
					
				&lt;/script>
			&lt;/div>

		&lt;/div>
		&lt;!-- modify veiw -->
		&lt;!-- button -->
		&lt;div class="btn-box clearfix mt-4">
			&lt;button class="btn btn-secondary">목록&lt;/button>
			&lt;div class="right float-end">
				&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
				&lt;button class="btn btn-danger">삭제&lt;/button>
				&lt;button class="btn btn-primary">수정&lt;/button>
			&lt;/div>
		&lt;/div>
		&lt;!-- button -->

		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 03 기본 수정 공통 폼(위키,서식,자주묻는 질문, 공지사항)-->

			<!-- ui 03  공통 가로형식 등록/수정폼-->
			<div class="ui" id="ui04">
				<strong class="ui-tit p-4">공통 등록/수정폼</strong>

				<div class="content">
					<div class="inner html">
							<!-- ui : s -->
							<!--  -->
							<div class="row my-3">
								<div class="col-12">
								1) 기타 등록페이지도 "항목"만 변경해서 사용하시면 됩니다.
							
	<code class="text-black">
	&lt;!-- datepicker css  수정 , 등록 페이지에만 -일감--><br>
	&lt;link rel="stylesheet" href="./resources/js/common/datepicker/jquery-ui.css"><br>
	&lt;!-- datepicker css  수정 , 등록 페이지에만 -일감--><br>
	&lt;!-- modify,edit페이지에서만 로드 --><br>
	&lt;script src="./resources/js/common/ckeditor4/ckeditor.js">&lt;/script><br>
	&lt;script src="./resources/js/common/datepicker/jquery-ui.js">&lt;/script><br>
	&lt;!-- modify,edit페이지에서만 로드 --><br>
	&lt;!-- datepicker lang --><br>
	&lt;script src="./resources/js/common/datepicker/lang/datepicker-ko.js">&lt;/script><br>
	&lt;!-- datepicker lang--><br>
	</code>
								
								</div>
							</div>
							<!--  -->
							<!-- modify veiw -->
							<div class="view edit">
								<div class="view_inner">
									<div class="view-info">
										<strong class="view-tit d-flex align-items-center">
											<div class="mx-2">
												<span class="category project">T00001</span>
											</div>
											<div class="col-sm-11">
												<input type="text" class="form-control" placeholder="제목을입력해주세요">
											</div>
											
										</strong>
										<ul class="ul clearfix">
											<li class="d-flex w-50  align-items-center mb-2">
												<span class="list-tit">작성자</span>
												<span class="col-sm-12">유길상(기획1팀)</span>
											</li>
											<!-- 담당자 -->
											<li class="d-flex w-50  align-items-center mb-2">
												<span class="list-tit">담당자</span>
												<span class="col-sm-6">
													<select class="form-select" aria-label="Default select example">
														<option value="김태은">김태은</option>
														<option value="우민규">우민규</option>
														<option value="정민지">정민지</option>
														<option value="이상철">이상철</option>
													</select> 
												</span>
											</li>
											<!-- 담당자  -->
											<!-- 일감상태 -->
											<li class="d-flex w-50  align-items-center mb-2">
												<span class="list-tit">상태</span>
												<span class="col-sm-6">
													<select class="form-select" aria-label="Default select example">
														<option value="일반">일반</option>
														<option value="긴급">긴급</option>
													</select> 
												</span>
											</li>
											<!-- 일감상태  -->
											<!-- 진행률  -->
											<!-- 10% : 대기  & 30%,50%,70%,90% : 진행중 & 99%: 처리완료 & 100%:최종완료 
												오늘의 일정과 일감의 목록에 진행률이 수정되면  자동반영되어야 함.  
												반려 처리는 99%(처리완료) 이하의 값으로 되면 "반려"처리로 카운트
											-->
											<li class="d-flex w-50  align-items-center mb-2">
												<span class="list-tit">진행률</span>
												<span class="col-sm-6">
													<select class="form-select" aria-label="Default select example">
														<option value="10%">10%</option>
														<option value="30%">30%</option>
														<option value="50%">50%</option>
														<option value="70%">70%</option>
														<option value="90%">90%</option>
														<option value="99%">90%</option>
														<!-- 프로젝트매니저만 보염 -->
														<option value="100%">100%</option>
														<!-- 프로젝트매니저만 보염 -->
													</select> 
												</span>
											</li>
											<!-- 진행률 -->
											<li class="d-flex w-50  align-items-center mb-2">
												<span class="list-tit">마감일</span>
												<span> 
													<input type="text" id="datepicker" class="form-control" value="날짜선택" />
												</span>
											</li>
											<li class="d-flex w-50  align-items-center mb-2">
												<span class="list-tit">등록일</span>
												<span>2024.04.04</span></li>
											</li>
											<!-- 일감 상태값:
														<li><span class="">상태</span><span>신규</span></li>
														<li><span class="">상태</span><span>안정</span></li>
														<li><span class="">상태</span><span>긴급</span></li>
												-->
										</ul>
									</div>
									<div class="view_content" id="viewEdit2" ></div>
									<!-- 첨부파일 -->
									<!-- 첨부파일 -->
									<script>
										let viewEdit2 = document.querySelector("#viewEdit2")
										
										CKEDITOR.replace(viewEdit2,{
											language: "ko",
										
										});
										
									</script>
									<script>
									// https://jqueryui.com/datepicker/#default
									//https://github.com/jquery/jquery-ui/tree/main/ui/i18n
									$( "#datepicker" ).datepicker({
										changeMonth: true,//월 선택
										changeYear: true,//년도선택
										showButtonPanel: true,//하단 버튼 패널
										closeText: "닫기",//닫기버튼
										currentText: "오늘",//당일 날짜
										showOn: "both",//포커스,버튼
										showAnim: "fadeIn",//애니메이션
										showOtherMonths: true,//다른달 날짜 보여주기
										dateFormat:"yy-mm-dd",
										//navigationAsDateFormat: true,
										//firstDay: 0,
										//numberOfMonths: 2,//여러달
										//showCurrentAtPos: 3
										//constrainInput: true,
									});
												
										
									</script>
								
								</div>

							</div>
							<!-- modify veiw -->
							<!-- button -->
							<div class="btn-box clearfix mt-4">
								<button class="btn btn-secondary">목록</button>
								<div class="right float-end">
									<!-- <button class="btn btn-danger">취소</button> -->
									<button class="btn btn-danger">삭제</button>
									<button class="btn btn-primary">수정</button>
								</div>
							</div>
							<!-- button -->
							<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->
		&lt;!-- datepicker css  수정 , 등록 페이지에만 -일감-->
		&lt;link rel="stylesheet" href="./resources/js/common/datepicker/jquery-ui.css">
		&lt;!-- datepicker css  수정 , 등록 페이지에만 -일감-->
		&lt;!-- modify,edit페이지에서만 로드 -->
		&lt;script src="./resources/js/common/ckeditor4/ckeditor.js">&lt;/script>
		&lt;script src="./resources/js/common/datepicker/jquery-ui.js">&lt;/script>
		&lt;!-- modify,edit페이지에서만 로드 -->
		&lt;!-- datepicker lang -->
		&lt;script src="./resources/js/common/datepicker/lang/datepicker-ko.js">&lt;/script>
		&lt;!-- datepicker lang-->

		&lt;!-- modify veiw -->
		&lt;div class="view edit">
			&lt;div class="view_inner">
				&lt;div class="view-info">
					&lt;strong class="view-tit d-flex align-items-center">
						&lt;div class="mx-2">
							&lt;span class="category project">T00001&lt;/span>
						&lt;/div>
						&lt;div class="col-sm-11">
							&lt;input type="text" class="form-control" placeholder="제목을입력해주세요">
						&lt;/div>
						
					&lt;/strong>
					&lt;ul class="ul clearfix">
						&lt;li class="d-flex w-50 align-items-center mb-2">
							&lt;span class="list-tit">작성자&lt;/span>
							&lt;span class="col-sm-12">유길상(기획1팀)&lt;/span>
						&lt;/li>
								
						&lt;!-- 담당자 -->
						&lt;li class="d-flex w-50  align-items-center mb-2">
							&lt;span class="list-tit">담당자&lt;/span>
							&lt;span class="col-sm-6">
								&lt;select class="form-select" aria-label="Default select example">
									&lt;option value="김태은">김태은&lt;/option>
									&lt;option value="우민규">우민규&lt;/option>
									&lt;option value="정민지">정민지&lt;/option>
									&lt;option value="이상철">이상철&lt;/option>
								&lt;/select> 
							&lt;/span>
						&lt;/li>
						&lt;!-- 담당자  -->

			
						&lt;!-- 일감상태 -->
						&lt;li class="d-flex w-50  align-items-center mb-2">
							&lt;span class="list-tit">상태&lt;/span>
							&lt;span class="col-sm-6">
								&lt;select class="form-select" aria-label="Default select example">
									&lt;option value="일반">일반&lt;/option>
									&lt;option value="긴급">긴급&lt;/option>
								&lt;/select> 
							&lt;/span>
						&lt;/li>
						&lt;!-- 일감상태  -->
						&lt;!-- 진행률  -->
						&lt;!-- 10% : 대기  & 30%,50%,70%,90% : 진행중 & 99%: 처리완료 & 100%:최종완료 
							오늘의 일정과 일감의 목록에 진행률이 수정되면  자동반영되어야 함.  
							반려 처리는 99%(처리완료) 이하의 값으로 되면 "반려"처리로 카운트
						-->
						&lt;li class="d-flex w-50  align-items-center mb-2">
							&lt;span class="list-tit">진행률&lt;/span>
							&lt;span class="col-sm-6">
								&lt;select class="form-select" aria-label="Default select example">
									&lt;option value="10%">10%&lt;/option>
									&lt;option value="30%">30%&lt;/option>
									&lt;option value="50%">50%&lt;/option>
									&lt;option value="70%">70%&lt;/option>
									&lt;option value="90%">90%&lt;/option>
									&lt;option value="99%">90%&lt;/option>
									&lt;!-- 프로젝트매니저만 보염 -->
									&lt;option value="100%">100%&lt;/option>
									&lt;!-- 프로젝트매니저만 보염 -->
								&lt;/select> 
							&lt;/span>
						&lt;/li>
						&lt;!-- 진행률 -->
						&lt;li class="d-flex w-50  align-items-center mb-2">
							&lt;span class="list-tit">마감일&lt;/span>
							&lt;span> 
								&lt;input type="text" id="datepicker" class="form-control" value="날짜선택" />
							&lt;/span>
						&lt;/li>
						&lt;li class="d-flex w-50  align-items-center mb-2">
							&lt;span class="list-tit">등록일&lt;/span>
							&lt;span>2024.04.04&lt;/span>&lt;/li>
						&lt;/li>
						&lt;!-- 일감 상태값:
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>신규&lt;/span>&lt;/li>
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>안정&lt;/span>&lt;/li>
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>긴급&lt;/span>&lt;/li>
							-->
					&lt;/ul>
				&lt;/div>
				&lt;div class="view_content" id="viewEdit2" >&lt;/div>
				&lt;!-- 첨부파일 -->
				&lt;!-- 첨부파일 -->
				&lt;script>
					let viewEdit2 = document.querySelector("#viewEdit2")
					
					CKEDITOR.replace(viewEdit2,{
						language: "ko",
					
					});
					
				&lt;/script>
				&lt;script>
				// https://jqueryui.com/datepicker/#default
				//https://github.com/jquery/jquery-ui/tree/main/ui/i18n
				$( "#datepicker" ).datepicker({
					changeMonth: true,//월 선택
					changeYear: true,//년도선택
					showButtonPanel: true,//하단 버튼 패널
					closeText: "닫기",//닫기버튼
					currentText: "오늘",//당일 날짜
					showOn: "both",//포커스,버튼
					showAnim: "fadeIn",//애니메이션
					showOtherMonths: true,//다른달 날짜 보여주기
					dateFormat:"yy-mm-dd",
					//navigationAsDateFormat: true,
					//firstDay: 0,
					//numberOfMonths: 2,//여러달
					//showCurrentAtPos: 3
					//constrainInput: true,
				});
							
					
				&lt;/script>
			
			&lt;/div>

		&lt;/div>
		&lt;!-- modify veiw -->
		&lt;!-- button -->
		&lt;div class="btn-box clearfix mt-4">
			&lt;button class="btn btn-secondary">목록&lt;/button>
			&lt;div class="right float-end">
				&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
				&lt;button class="btn btn-danger">삭제&lt;/button>
				&lt;button class="btn btn-primary">수정&lt;/button>
			&lt;/div>
		&lt;/div>
		&lt;!-- button -->

		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 03 공통 등록/수정폼 -->

			<!-- ui 04 공통폼 세로형식 수정/등록-->
			<div class="ui" id="ui05">
				<strong class="ui-tit p-4"> 공통Form 수정/등록</small></strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- retreive -->
						<div class="">
							<!-- form -->
							<form class="commonForm" action="">
								<fieldset>
									<legend>
										<span class="sr-only">?? 수정</span>
									</legend>

									<!-- 프로필 -->
									<div class="row profil">
										<div class="label col-sm-3">
											<label for="profilFile" class="form-label">프로필</label>
										</div>
										<div class="form_content col-sm-6">
											<div class="profil_img block">
												<div class="img-in">
													<img src="./resources/images/prog/navi.jpg" alt="프로필이미지">
												</div>
											</div>
											<div class="file block">
												<span class="filebtn btn btn-secondary">파일첨부</span>
												<input class="fileInput" id="profilFile" type="file">
												<!-- accept="image/png, image/jpeg, image/gif" -->
											</div>
										</div>
										<!-- profil script -->
										<script>
											function profilImg() {
												// 첨부 input 변수 가져오기
												let addfile = document.querySelector("#profilFile");
												// 첨부된 이미지 요소
												let imgPath = document.querySelector(".profil_img img");

												addfile.addEventListener("change", (event) => {
													let thisTarget = event.target;
													let fileType = thisTarget.files[0].type;

													// 마임 타입이 이미지가 아니면 종료
													if (!fileType.match(/image\//)) {
														alert("이미지 파일을 첨부해주세요.");
														return;
													}

													// 파일 리더 생성
													let reader = new FileReader();

													// 파일을 읽었을 때의 이벤트 처리
													reader.onload = function () {
														// 이미지 경로 설정
														imgPath.src = reader.result;
													};

													// 파일을 읽기 시작
													reader.readAsDataURL(thisTarget.files[0]);
												});
											}

											profilImg();

										</script>
										<!-- profil script -->
									</div>
									<!-- 프로필 -->

									<!-- 이름 -->
									<div class="row text">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">성명</label>
										</div>
										<div class="form_content col-sm-6">
											<input type="text" class="form-control" placeholder="성명입력">
										</div>
									</div>
									<!-- 이름 -->
									<!-- 담당자 -->
									<div class="row text">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">담당자</label>
										</div>
										<div class="form_content col-sm-9">
											<input type="text" class="form-control" placeholder="담당자입력">
										</div>
									</div>
									<!-- 담당자 -->
									<!-- 핸드폰 -->
									<div class="row tel">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">전화번호</label>
										</div>
										<div class="form_content col-sm-9 d-flex">
											<div class="input col-sm-3">
												<select class="form-select" aria-label="Default select example"
													title="첫번째 전화번호를 선택해주세요">
													<option selected>010</option>
													<option value="1">063</option>
													<option value="2">042</option>
													<option value="3">02</option>
												</select>
											</div>
											<span class="entity">-</span>
											<div class="input col-sm-3">
												<input type="text" class="form-control" title="두번째 전화번호를 입력해주세요">
											</div>
											<span class="entity">-</span>
											<div class="input col-sm-3">
												<input type="text" class="form-control" title="3번째 전화번호를 입력해주세요">
											</div>
										</div>
									</div>
									<!-- 핸드폰 -->
									<!-- 주민번호 -->
									<div class="row identifyNum">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">주민번호</label>
										</div>
										<div class="form_content col-sm-6 d-flex">
											<div class="input col-sm-6">
												<input type="text" class="form-control" placeholder="주민번호 앞자리립력">
											</div>
											<span class="entity">-</span>
											<div class="input col-sm-6">
												<input type="text" class="form-control" placeholder="주민번호 뒷자리입력">
											</div>
										</div>
									</div>
									<!-- 주민번호 -->
									<!-- 이메일 -->
									<div class="row email">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">이메일</label>
										</div>
										<div class="form_content col-sm-9 d-flex">
											<div class="input col-sm-3">
												<input type="text" class="form-control" placeholder="이메일 아이디입력">
											</div>
											<span class="entity">@</span>
											<div class="input col-sm-4">
												<input type="text" class="form-control" placeholder="이메일 주소입력">
											</div>
											<div class="input col-sm-2 ms-1">
												<select class="form-select" aria-label="Default select example"
													title="이메일선택">
													<option selected="">직접입력</option>
													<option value="1">naver.com</option>
													<option value="2">daum.com</option>
													<option value="3">gmail.com</option>
												</select>
											</div>
										</div>
									</div>
									<!-- 이메일 -->
									<!-- 주소 -->
									<div class="row address">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">주소</label>
										</div>
										<div class="form_content col-sm-9">
											<div class="input col-sm-6  d-flex mb-1">
												<input type="text" class="form-control" placeholder="주소입력">
												<button type="submit" class="btn btn-secondary ms-1">주소검색</button>
											</div>
											<div class="input col-sm-9">
												<input type="text" class="form-control" placeholder="상세주소입력">
											</div>
										</div>
									</div>
									<!-- 주소 -->
									<!-- 셀렉트박스1 -->
									<div class="row select">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">선택박스</label>
										</div>
										<div class="form_content col-sm-9 d-flex">
											<div class="input col-sm-3 mx-1">
												<select class="form-select" aria-label="Default select example"
													title="첫번째 전화번호를 선택해주세요">
													<option selected>010</option>
													<option value="1">063</option>
													<option value="2">042</option>
													<option value="3">02</option>
												</select>
											</div>
										</div>
									</div>
									<!-- 셀렉트박스1-->
									<!-- 셀렉트박스2 -->
									<div class="row select">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">선택박스</label>
										</div>
										<div class="form_content col-sm-9 d-flex">
											<div class="input col-sm-3 mx-1">
												<select class="form-select" aria-label="Default select example"
													title="첫번째 전화번호를 선택해주세요">
													<option selected>010</option>
													<option value="1">063</option>
													<option value="2">042</option>
													<option value="3">02</option>
												</select>
											</div>
											<div class="input col-sm-3 mx-1">
												<select class="form-select" aria-label="Default select example"
													title="첫번째 전화번호를 선택해주세요">
													<option selected>010</option>
													<option value="1">063</option>
													<option value="2">042</option>
													<option value="3">02</option>
												</select>
											</div>
											<div class="input col-sm-3 mx-1">
												<select class="form-select" aria-label="Default select example"
													title="첫번째 전화번호를 선택해주세요">
													<option selected>010</option>
													<option value="1">063</option>
													<option value="2">042</option>
													<option value="3">02</option>
												</select>
											</div>
										</div>
									</div>
									<!-- 셀렉트박스2 -->

									<!-- 체크박스 -->
									<div class="row checkbox">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">체크박스</label>
										</div>
										<div class="form_content col-sm-9 d-flex">

											<div class="form-check form-check-inline">
												<input class="form-check-input" type="checkbox" id="inlineCheckbox1"
													value="option1">
												<label class="form-check-label" for="inlineCheckbox1">1</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="checkbox" id="inlineCheckbox2"
													value="option2">
												<label class="form-check-label" for="inlineCheckbox2">2</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="checkbox" id="inlineCheckbox3"
													value="option3" disabled>
												<label class="form-check-label" for="inlineCheckbox3">3
													(disabled)</label>
											</div>

										</div>
									</div>
									<!-- 체크박스 -->

									<!-- 라디오 -->
									<div class="row checkbox">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">라디오</label>
										</div>
										<div class="form_content col-sm-9 d-flex">

											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="inlineRadioOptions"
													id="inlineRadio1" value="option1">
												<label class="form-check-label" for="inlineRadio1">1</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="inlineRadioOptions"
													id="inlineRadio2" value="option2">
												<label class="form-check-label" for="inlineRadio2">2</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="inlineRadioOptions"
													id="inlineRadio3" value="option3" disabled>
												<label class="form-check-label" for="inlineRadio3">3 (disabled)</label>
											</div>

										</div>
									</div>
									<!-- 라디오 -->


									<!-- 여러줄 텍스트 -->
									<div class="row">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">텍스트
											</label>
										</div>
										<div class="form_content col-sm-9">
											<textarea class="form-control" name="" id="" cols="30" rows="10"></textarea>
										</div>
									</div>
									<!--여러줄 텍스트 -->
								</fieldset>
							</form>
							<!-- form -->
							<div class="btn-box clearfix mt-4">
								<button class="btn btn-secondary">뒤로</button>
								<div class="right float-end">
									<!-- <button class="btn btn-danger">취소</button> -->
									<button class="btn btn-danger">취소</button>
									<button class="btn btn-primary">완료</button>
								</div>
							</div>
						</div>
						<!-- retreive -->

						<!-- ui : e -->

					</div>
				</div>
				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
										<code data-clipboard-text="">
				<!-- Code Start -->
				&lt;!-- retreive -->
				&lt;div class="">
					&lt;!-- form -->
					&lt;form class="commonForm" action="">
						&lt;fieldset>
							&lt;legend>
								&lt;span class="sr-only">?? 수정&lt;/span>
							&lt;/legend>
			
							&lt;!-- 프로필 -->
							&lt;div class="row profil">
								&lt;div class="label col-sm-3">
									&lt;label for="profilFile" class="form-label">프로필&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-6">
									&lt;div class="profil_img block">
										&lt;div class="img-in">
											&lt;img src="./resources/images/prog/navi.jpg" alt="프로필이미지">
										&lt;/div>
									&lt;/div>
									&lt;div class="file block">
										&lt;span class="filebtn btn btn-secondary">파일첨부&lt;/span>
										&lt;input class="fileInput" id="profilFile" type="file">
										&lt;!-- accept="image/png, image/jpeg, image/gif" -->
									&lt;/div>
								&lt;/div>
								&lt;!-- profil script -->
								&lt;script>
									function profilImg() {
										// 첨부 input 변수 가져오기
										let addfile = document.querySelector("#profilFile");
										// 첨부된 이미지 요소
										let imgPath = document.querySelector(".profil_img img");
			
										addfile.addEventListener("change", (event) => {
											let thisTarget = event.target;
											let fileType = thisTarget.files[0].type;
			
											// 마임 타입이 이미지가 아니면 종료
											if (!fileType.match(/image\//)) {
												alert("이미지 파일을 첨부해주세요.");
												return;
											}
			
											// 파일 리더 생성
											let reader = new FileReader();
			
											// 파일을 읽었을 때의 이벤트 처리
											reader.onload = function () {
												// 이미지 경로 설정
												imgPath.src = reader.result;
											};
			
											// 파일을 읽기 시작
											reader.readAsDataURL(thisTarget.files[0]);
										});
									}
			
									profilImg();
			
								&lt;/script>
								&lt;!-- profil script -->
							&lt;/div>
							&lt;!-- 프로필 -->
			
							&lt;!-- 이름 -->
							&lt;div class="row text">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">성명&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-6">
									&lt;input type="text" class="form-control" placeholder="성명입력">
								&lt;/div>
							&lt;/div>
							&lt;!-- 이름 -->
							&lt;!-- 담당자 -->
							&lt;div class="row text">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">담당자&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9">
									&lt;input type="text" class="form-control" placeholder="담당자입력">
								&lt;/div>
							&lt;/div>
							&lt;!-- 담당자 -->
							&lt;!-- 핸드폰 -->
							&lt;div class="row tel">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">전화번호&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9 d-flex">
									&lt;div class="input col-sm-3">
										&lt;select class="form-select" aria-label="Default select example"
											title="첫번째 전화번호를 선택해주세요">
											&lt;option selected>010&lt;/option>
											&lt;option value="1">063&lt;/option>
											&lt;option value="2">042&lt;/option>
											&lt;option value="3">02&lt;/option>
										&lt;/select>
									&lt;/div>
									&lt;span class="entity">-&lt;/span>
									&lt;div class="input col-sm-3">
										&lt;input type="text" class="form-control" title="두번째 전화번호를 입력해주세요">
									&lt;/div>
									&lt;span class="entity">-&lt;/span>
									&lt;div class="input col-sm-3">
										&lt;input type="text" class="form-control" title="3번째 전화번호를 입력해주세요">
									&lt;/div>
								&lt;/div>
							&lt;/div>
							&lt;!-- 핸드폰 -->
							&lt;!-- 주민번호 -->
							&lt;div class="row identifyNum">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">주민번호&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-6 d-flex">
									&lt;div class="input col-sm-6">
										&lt;input type="text" class="form-control" placeholder="주민번호 앞자리립력">
									&lt;/div>
									&lt;span class="entity">-&lt;/span>
									&lt;div class="input col-sm-6">
										&lt;input type="text" class="form-control" placeholder="주민번호 뒷자리입력">
									&lt;/div>
								&lt;/div>
							&lt;/div>
							&lt;!-- 주민번호 -->
							&lt;!-- 이메일 -->
							&lt;div class="row email">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">이메일&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9 d-flex">
									&lt;div class="input col-sm-3">
										&lt;input type="text" class="form-control" placeholder="이메일 아이디입력">
									&lt;/div>
									&lt;span class="entity">@&lt;/span>
									&lt;div class="input col-sm-4">
										&lt;input type="text" class="form-control" placeholder="이메일 주소입력">
									&lt;/div>
									&lt;div class="input col-sm-2 ms-1">
										&lt;select class="form-select" aria-label="Default select example"
											title="이메일선택">
											&lt;option selected="">직접입력&lt;/option>
											&lt;option value="1">naver.com&lt;/option>
											&lt;option value="2">daum.com&lt;/option>
											&lt;option value="3">gmail.com&lt;/option>
										&lt;/select>
									&lt;/div>
								&lt;/div>
							&lt;/div>
							&lt;!-- 이메일 -->
							&lt;!-- 주소 -->
							&lt;div class="row address">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">주소&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9">
									&lt;div class="input col-sm-6  d-flex mb-1">
										&lt;input type="text" class="form-control" placeholder="주소입력">
										&lt;button type="submit" class="btn btn-secondary ms-1">주소검색&lt;/button>
									&lt;/div>
									&lt;div class="input col-sm-9">
										&lt;input type="text" class="form-control" placeholder="상세주소입력">
									&lt;/div>
								&lt;/div>
							&lt;/div>
							&lt;!-- 주소 -->
							&lt;!-- 셀렉트박스1 -->
							&lt;div class="row select">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">선택박스&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9 d-flex">
									&lt;div class="input col-sm-3 mx-1">
										&lt;select class="form-select" aria-label="Default select example"
											title="첫번째 전화번호를 선택해주세요">
											&lt;option selected>010&lt;/option>
											&lt;option value="1">063&lt;/option>
											&lt;option value="2">042&lt;/option>
											&lt;option value="3">02&lt;/option>
										&lt;/select>
									&lt;/div>
								&lt;/div>
							&lt;/div>
							&lt;!-- 셀렉트박스1-->
							&lt;!-- 셀렉트박스2 -->
							&lt;div class="row select">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">선택박스&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9 d-flex">
									&lt;div class="input col-sm-3 mx-1">
										&lt;select class="form-select" aria-label="Default select example"
											title="첫번째 전화번호를 선택해주세요">
											&lt;option selected>010&lt;/option>
											&lt;option value="1">063&lt;/option>
											&lt;option value="2">042&lt;/option>
											&lt;option value="3">02&lt;/option>
										&lt;/select>
									&lt;/div>
									&lt;div class="input col-sm-3 mx-1">
										&lt;select class="form-select" aria-label="Default select example"
											title="첫번째 전화번호를 선택해주세요">
											&lt;option selected>010&lt;/option>
											&lt;option value="1">063&lt;/option>
											&lt;option value="2">042&lt;/option>
											&lt;option value="3">02&lt;/option>
										&lt;/select>
									&lt;/div>
									&lt;div class="input col-sm-3 mx-1">
										&lt;select class="form-select" aria-label="Default select example"
											title="첫번째 전화번호를 선택해주세요">
											&lt;option selected>010&lt;/option>
											&lt;option value="1">063&lt;/option>
											&lt;option value="2">042&lt;/option>
											&lt;option value="3">02&lt;/option>
										&lt;/select>
									&lt;/div>
								&lt;/div>
							&lt;/div>
							&lt;!-- 셀렉트박스2 -->
			
							&lt;!-- 체크박스 -->
							&lt;div class="row checkbox">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">체크박스&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9 d-flex">
			
									&lt;div class="form-check form-check-inline">
										&lt;input class="form-check-input" type="checkbox" id="inlineCheckbox1"
											value="option1">
										&lt;label class="form-check-label" for="inlineCheckbox1">1&lt;/label>
									&lt;/div>
									&lt;div class="form-check form-check-inline">
										&lt;input class="form-check-input" type="checkbox" id="inlineCheckbox2"
											value="option2">
										&lt;label class="form-check-label" for="inlineCheckbox2">2&lt;/label>
									&lt;/div>
									&lt;div class="form-check form-check-inline">
										&lt;input class="form-check-input" type="checkbox" id="inlineCheckbox3"
											value="option3" disabled>
										&lt;label class="form-check-label" for="inlineCheckbox3">3 (disabled)&lt;/label>
									&lt;/div>
			
								&lt;/div>
							&lt;/div>
							&lt;!-- 체크박스 -->
			
							&lt;!-- 라디오 -->
							&lt;div class="row checkbox">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">라디오&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9 d-flex">
			
									&lt;div class="form-check form-check-inline">
										&lt;input class="form-check-input" type="radio" name="inlineRadioOptions"
											id="inlineRadio1" value="option1">
										&lt;label class="form-check-label" for="inlineRadio1">1&lt;/label>
									&lt;/div>
									&lt;div class="form-check form-check-inline">
										&lt;input class="form-check-input" type="radio" name="inlineRadioOptions"
											id="inlineRadio2" value="option2">
										&lt;label class="form-check-label" for="inlineRadio2">2&lt;/label>
									&lt;/div>
									&lt;div class="form-check form-check-inline">
										&lt;input class="form-check-input" type="radio" name="inlineRadioOptions"
											id="inlineRadio3" value="option3" disabled>
										&lt;label class="form-check-label" for="inlineRadio3">3 (disabled)&lt;/label>
									&lt;/div>
			
								&lt;/div>
							&lt;/div>
							&lt;!-- 라디오 -->
			
			
							&lt;!-- 여러줄 텍스트 -->
							&lt;div class="row">
								&lt;div class="label col-sm-3">
									&lt;label for="disabledTextInput" class="form-label">텍스트
									&lt;/label>
								&lt;/div>
								&lt;div class="form_content col-sm-9">
									&lt;textarea class="form-control" name="" id="" cols="30" rows="10">&lt;/textarea>
								&lt;/div>
							&lt;/div>
							&lt;!--여러줄 텍스트 -->
						&lt;/fieldset>
					&lt;/form>
					&lt;!-- form -->
					&lt;div class="btn-box clearfix mt-4">
						&lt;button class="btn btn-secondary">뒤로&lt;/button>
						&lt;div class="right float-end">
							&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
							&lt;button class="btn btn-danger">취소&lt;/button>
							&lt;button class="btn btn-primary">완료&lt;/button>
						&lt;/div>
					&lt;/div>
				&lt;/div>
				&lt;!-- retreive -->
				<!-- Code END -->
										</code>
									</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 04 공통폼 수정 등록-->

			<!-- ui 05 일감상세-->
			<div class="ui" id="ui06">
				<strong class="ui-tit p-4">일감상세</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<div class="row my-3">
						<div class="col-12">
							1) 위키상세, 서식상세 커스텀해서 사용하세요<br>
							2) 위키리스트명 : 작성자, 틍록일 , 수정일
							3) 서식리스트명 : 작성자, 등록일, 수정일
							중요) view 클래스 옆에 위키(wiki) , 서식(form) 클래스 변경해서 사용하기<br>
							하단 태그 참고
						</div>
					</div>
						<!-- project veiw -->
						<div class="view task">
							<div class="view_inner">
								<div class="view-info">
									<strong class="view-tit">
										<span class="category project">T00001</span>
										<em>2024대덕인재개발원 리뉴얼</em></strong>
									<ul class="ul clearfix">

										<li><span class="list-tit">담당자</span>
											<span>우민규(디자인1팀, 사원)</span>
											<!-- <select class="select-box" aria-label="Default select example">
                                    <option selected>우민규(디자인1팀, 사원)</option>
                                    <option value="1">유길상(디자인1팀, 사원)</option>
                                    <option value="2">정민지(디자인1팀, 사원)</option>
                                    <option value="4">이상철(디자인1팀, 사원)</option>
                                    <option value="5">김태은(디자인1팀, 사원)</option>
                                </select> -->
										</li>
										<!-- <li><span class="list-tit">진행기간</span><span>2024.04.05</span></li> -->
										<li>
											<span class="list-tit">진행율</span>
											<div class="progress">
												<div class="progress-bar" role="progressbar"
													aria-label="Example with label" style="width: 30%;"
													aria-valuenow="30" aria-valuemin="0" aria-valuemax="100">30%</div>
											</div>
											<!-- <select class="select-box" aria-label="Default select example">
                                    <option selected>10%</option>
                                    <option value="1">30%</option>
                                    <option value="2">50%</option>
                                    <option value="3">70%</option>
                                    <option value="4">90%</option>
                                    <option value="5">99%</option>
                                </select> -->
										</li>
										<li><span class="list-tit">처리기한</span>
											<span>2024.08.31</span>

										</li>
										<li><span class="list-tit">수정일</span>
											<span>2024.04.05</span>
										</li>
										<li><span class="list-tit">등록일</span><span>2024.04.04</span></li>
										<!-- 프로젝트 상태값:
                                        <li><span class="">상태</span><span>신규</span></li>
                                        <li><span class="">상태</span><span>안정</span></li>
                                        <li><span class="">상태</span><span>긴급</span></li>
                                -->

									</ul>
								</div>
								<div class="view_content">
									(삭제예정)<br>
									진행율을 선택하면 데이터베이스에 처리상태가 자동반영 -> 오늘의 일정.<br>

									진행률 = 처리상태<br>
									10% = 대기<br>
									30%, 50%, 70%, 90% = 진행중<br>
									99% = 처리완료<br>
									100% = 최종완료<br>
									99% -> 30% = 반려<br>
									진행률이 선택되면 처리상태가 자동반영<br>
									<br>
									첨부파일은 위키 상세, 수정과 동일

								</div>
							</div>

						</div>
						<!-- project veiw -->
						<!-- button -->
						<div class="btn-box clearfix mt-4">
							<button class="btn btn-secondary">목록</button>
							<div class="right float-end">
								<!-- <button class="btn btn-danger">취소</button> -->
								<button class="btn btn-danger">삭제</button>
								<button class="btn btn-primary">수정</button>
							</div>
						</div>
						<!-- button -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
							<code data-clipboard-text="">
			<!-- Code Start -->
			&lt;!-- project veiw -->
						&lt;div class="view task">
							&lt;div class="view_inner">
								&lt;div class="view-info">
									&lt;strong class="view-tit">
										&lt;span class="category project">T00001&lt;/span>
										&lt;em>2024대덕인재개발원 리뉴얼&lt;/em>&lt;/strong>
									&lt;ul class="ul clearfix">

										&lt;li>&lt;span class="list-tit">담당자&lt;/span>
											&lt;span>우민규(디자인1팀, 사원)&lt;/span>
											&lt;!-- &lt;select class="select-box" aria-label="Default select example">
                                    &lt;option selected>우민규(디자인1팀, 사원)&lt;/option>
                                    &lt;option value="1">유길상(디자인1팀, 사원)&lt;/option>
                                    &lt;option value="2">정민지(디자인1팀, 사원)&lt;/option>
                                    &lt;option value="4">이상철(디자인1팀, 사원)&lt;/option>
                                    &lt;option value="5">김태은(디자인1팀, 사원)&lt;/option>
                                &lt;/select> -->
										&lt;/li>
										&lt;!-- &lt;li>&lt;span class="list-tit">진행기간&lt;/span>&lt;span>2024.04.05&lt;/span>&lt;/li> -->
										&lt;li>
											&lt;span class="list-tit">진행율&lt;/span>
											&lt;div class="progress">
												&lt;div class="progress-bar" role="progressbar"
													aria-label="Example with label" style="width: 30%;"
													aria-valuenow="30" aria-valuemin="0" aria-valuemax="100">30%&lt;/div>
											&lt;/div>
											&lt;!-- &lt;select class="select-box" aria-label="Default select example">
                                    &lt;option selected>10%&lt;/option>
                                    &lt;option value="1">30%&lt;/option>
                                    &lt;option value="2">50%&lt;/option>
                                    &lt;option value="3">70%&lt;/option>
                                    &lt;option value="4">90%&lt;/option>
                                    &lt;option value="5">99%&lt;/option>
                                &lt;/select> -->
										&lt;/li>
										&lt;li>&lt;span class="list-tit">처리기한&lt;/span>
											&lt;span>2024.08.31&lt;/span>

										&lt;/li>
										&lt;li>&lt;span class="list-tit">수정일&lt;/span>
											&lt;span>2024.04.05&lt;/span>
										&lt;/li>
										&lt;li>&lt;span class="list-tit">등록일&lt;/span>&lt;span>2024.04.04&lt;/span>&lt;/li>
										&lt;!-- 프로젝트 상태값:
                                        &lt;li>&lt;span class="">상태&lt;/span>&lt;span>신규&lt;/span>&lt;/li>
                                        &lt;li>&lt;span class="">상태&lt;/span>&lt;span>안정&lt;/span>&lt;/li>
                                        &lt;li>&lt;span class="">상태&lt;/span>&lt;span>긴급&lt;/span>&lt;/li>
                                -->

									&lt;/ul>
								&lt;/div>
								&lt;div class="view_content">
									(삭제예정)&lt;br>
									진행율을 선택하면 데이터베이스에 처리상태가 자동반영 -> 오늘의 일정.&lt;br>

									진행률 = 처리상태&lt;br>
									10% = 대기&lt;br>
									30%, 50%, 70%, 90% = 진행중&lt;br>
									99% = 처리완료&lt;br>
									100% = 최종완료&lt;br>
									99% -> 30% = 반려&lt;br>
									진행률이 선택되면 처리상태가 자동반영&lt;br>
									&lt;br>
									첨부파일은 위키 상세, 수정과 동일

								&lt;/div>
							&lt;/div>

						&lt;/div>
						&lt;!-- project veiw -->
						&lt;!-- button -->
						&lt;div class="btn-box clearfix mt-4">
							&lt;button class="btn btn-secondary">목록&lt;/button>
							&lt;div class="right float-end">
								&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
								&lt;button class="btn btn-danger">삭제&lt;/button>
								&lt;button class="btn btn-primary">수정&lt;/button>
							&lt;/div>
						&lt;/div>
						&lt;!-- button -->
			
			<!-- Code END -->
							</code>
						</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 05 일감상세 -->

			<!-- ui 05 일감목록-->
			<div class="ui" id="ui07">
				<strong class="ui-tit p-4">일감목록</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<div class="row my-3">
							<div class="col-12">
								1) 설명글입니다
							</div>
						</div>
						<!-- ui : table s -->
						<table class="table text-center">
							<caption class="sr-only">일감목록 테이블입니다.</caption>
							<colgroup>
								<col style="width:5%">
								<col style="width: 8%;">
								<col style="width: 10%;">
								<col style="width: 10%;">
								<col style="width: auto;">
								<col style="width: 10%;">
								<col style="width: 10%;">
								<col style="width: 10%;">
							</colgroup>

							<thead>
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="col">번호</th>
									<th scope="col">일감ID</th>
									<th scope="col">상태</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">진행상태</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tbody>
								<!-- 일반 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000002</th>
									<th scope="row">T00002</th>
									<td>
										<span class="category ordinary">일반</span>
									</td>
									<td class="text-start">
										<!-- 새글일 때 new 클래스 추가 -->
										<a href="#" class="text-link d-flex new">
											<!-- icon new_icon 추가 -->
											<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
											<em class="text-elipsis">일감이다 일감일다
												일감임어ㅣㄴㅇ마러;ㄴㅇ마ㅣㄻㄴ이ㅏㄼㄷ;ㅐㅑ롣ㅈㅁㄴㅇ라ㅐㅕㅁㄴ;ㅣㅇ렁ㄴ마ㅣ;ㄹ</em>
										</a>
									</td>
									<td>유길상</td>
									<td>
										<div class="progress">
											<div class="progress-bar" role="progressbar" aria-label="Example with label"
												style="width: 30%;" aria-valuenow="30" aria-valuemin="0"
												aria-valuemax="100">30%</div>
										</div>
									</td>
									<td>24.03.01</td>
								</tr>
								<!-- 일반 -->
								<!-- 긴급 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000002</th>
									<th scope="row">T00002</th>
									<td>
										<span class="category emergency">긴급</span>
									</td>
									<td class="text-start">
										<!-- 새글일 때 new 클래스 추가 -->
										<a href="#" class="text-link d-flex new">
											<!-- icon new_icon 추가 -->
											<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
											<em class="text-elipsis">일감이다 일감일다
												일감임어ㅣㄴㅇ마러;ㄴㅇ마ㅣㄻㄴ이ㅏㄼㄷ;ㅐㅑ롣ㅈㅁㄴㅇ라ㅐㅕㅁㄴ;ㅣㅇ렁ㄴ마ㅣ;ㄹ</em>
										</a>
									</td>
									<td>유길상</td>
									<td>
										<div class="progress">
											<div class="progress-bar" role="progressbar" aria-label="Example with label"
												style="width: 90%;" aria-valuenow="90" aria-valuemin="0"
												aria-valuemax="100">90%</div>
										</div>
									</td>
									<td>24.03.01</td>
								</tr>
								<!-- 긴급 -->
								<!-- 신규 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000002</th>
									<th scope="row">T00002</th>
									<td>
										<span class="category new">신규</span>
									</td>
									<td class="text-start">
										<!-- 새글일 때 new 클래스 추가 -->
										<a href="#" class="text-link d-flex new">
											<!-- icon new_icon 추가 -->
											<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
											<em class="text-elipsis">일감이다 일감일다
												일감임어ㅣㄴㅇ마러;ㄴㅇ마ㅣㄻㄴ이ㅏㄼㄷ;ㅐㅑ롣ㅈㅁㄴㅇ라ㅐㅕㅁㄴ;ㅣㅇ렁ㄴ마ㅣ;ㄹ</em>
										</a>
									</td>
									<td>유길상</td>
									<td>
										<div class="progress">
											<div class="progress-bar" role="progressbar" aria-label="Example with label"
												style="width: 60%;" aria-valuenow="60" aria-valuemin="0"
												aria-valuemax="100">60%</div>
										</div>
									</td>
									<td>24.03.01</td>
								</tr>
								<!-- 신규 -->

							</tbody>

						</table>
						<!-- 버튼 알아서 퍼가셈 -->
						<div class="btn-box clearfix mt-4">
							<div class="right float-end">
								<!-- <button class="btn btn-danger">취소</button> -->
								<button class="btn btn-danger">삭제</button>
								<button class="btn btn-primary">수정</button>
							</div>
						</div>
						<!-- 알아서 퍼가셈 -->
						<div class="btn-box clearfix mt-4">
							<div class="right float-end">
								<button class="btn btn-primary">등록</button>
							</div>
						</div>
						<!-- 버튼 알아서 퍼가셈 -->
						<!-- ui : table e -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
									<code data-clipboard-text="">
			<!-- Code Start -->
			&lt;!-- ui : table s -->
			&lt;table class="table text-center">
				&lt;caption class="sr-only">일감목록 테이블입니다.&lt;/caption>
				&lt;colgroup>
					&lt;col style="width:5%">
					&lt;col style="width: 8%;">
					&lt;col style="width: 10%;">
					&lt;col style="width: 10%;">
					&lt;col style="width: auto;">
					&lt;col style="width: 10%;">
					&lt;col style="width: 10%;">
					&lt;col style="width: 10%;">
				&lt;/colgroup>

				&lt;thead>
					&lt;tr>
						&lt;th>
							&lt;input type="checkbox">
						&lt;/th>
						&lt;th scope="col">번호&lt;/th>
						&lt;th scope="col">일감ID&lt;/th>
						&lt;th scope="col">상태&lt;/th>
						&lt;th scope="col">제목&lt;/th>
						&lt;th scope="col">작성자&lt;/th>
						&lt;th scope="col">진행상태&lt;/th>
						&lt;th scope="col">등록일&lt;/th>
					&lt;/tr>
				&lt;/thead>
				&lt;tbody>
						&lt;!-- 일반 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">000002&lt;/th>
							&lt;th scope="row">T00002&lt;/th>
							&lt;td>
								&lt;span class="category ordinary">일반&lt;/span>
							&lt;/td>
							&lt;td class="text-start">
								&lt;!-- 새글일 때 new 클래스 추가 -->
								&lt;a href="#" class="text-link d-flex new">
									&lt;!-- icon new_icon 추가 -->
									&lt;span class="icon new_icon">
										&lt;span class="sr-only">new&lt;/span>
									&lt;/span>
									&lt;em class="text-elipsis">일감이다  일감일다 일감임어ㅣㄴㅇ마러;ㄴㅇ마ㅣㄻㄴ이ㅏㄼㄷ;ㅐㅑ롣ㅈㅁㄴㅇ라ㅐㅕㅁㄴ;ㅣㅇ렁ㄴ마ㅣ;ㄹ&lt;/em>
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
						&lt;/tr>
						&lt;!-- 일반 -->
						&lt;!-- 긴급 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">000002&lt;/th>
							&lt;th scope="row">T00002&lt;/th>
							&lt;td>
								&lt;span class="category emergency">긴급&lt;/span>
							&lt;/td>
							&lt;td class="text-start">
								&lt;!-- 새글일 때 new 클래스 추가 -->
								&lt;a href="#" class="text-link d-flex new">
									&lt;!-- icon new_icon 추가 -->
									&lt;span class="icon new_icon">
										&lt;span class="sr-only">new&lt;/span>
									&lt;/span>
									&lt;em class="text-elipsis">일감이다  일감일다 일감임어ㅣㄴㅇ마러;ㄴㅇ마ㅣㄻㄴ이ㅏㄼㄷ;ㅐㅑ롣ㅈㅁㄴㅇ라ㅐㅕㅁㄴ;ㅣㅇ렁ㄴ마ㅣ;ㄹ&lt;/em>
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
						&lt;/tr>
						&lt;!-- 긴급 -->
						&lt;!-- 신규 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">000002&lt;/th>
							&lt;th scope="row">T00002&lt;/th>
							&lt;td>
								&lt;span class="category new">신규&lt;/span>
							&lt;/td>
							&lt;td class="text-start">
								&lt;!-- 새글일 때 new 클래스 추가 -->
								&lt;a href="#" class="text-link d-flex new">
									&lt;!-- icon new_icon 추가 -->
									&lt;span class="icon new_icon">
										&lt;span class="sr-only">new&lt;/span>
									&lt;/span>
									&lt;em class="text-elipsis">일감이다  일감일다 일감임어ㅣㄴㅇ마러;ㄴㅇ마ㅣㄻㄴ이ㅏㄼㄷ;ㅐㅑ롣ㅈㅁㄴㅇ라ㅐㅕㅁㄴ;ㅣㅇ렁ㄴ마ㅣ;ㄹ&lt;/em>
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
						&lt;/tr>
						&lt;!-- 신규 -->
				
				&lt;/tbody>

			&lt;/table>
			&lt;!-- 버튼 알아서 퍼가셈 -->
			&lt;div class="btn-box clearfix mt-4">
				&lt;div class="right float-end">
					&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
					&lt;button class="btn btn-danger">삭제&lt;/button>
					&lt;button class="btn btn-primary">수정&lt;/button>
				&lt;/div>
			&lt;/div>
			&lt;!-- 알아서 퍼가셈 -->
			&lt;div class="btn-box clearfix mt-4">
				&lt;div class="right float-end">
					&lt;button class="btn btn-primary">등록&lt;/button>
				&lt;/div>
			&lt;/div>
			&lt;!-- 버튼 알아서 퍼가셈 -->
			&lt;!-- ui : table e -->
			
			<!-- Code END -->
									</code>
								</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 05 일감목록-->


			<!-- ui 05 커뮤니티게시판(칭찬/나눔/포토/ )-->
			<div class="ui" id="ui08">
				<strong class="ui-tit p-4">커뮤니티게시판</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<div class="row my-3">
							<div class="col-12">
								1) 관리자 게시판은 전부 기본테이블 형식으로 진행<br>
								2) 칭찬세기판, 포토게시판 , 자주묻는 게세판, QnA게시판은 <br>
								테이블 컬럼명변경 및 컬럼 추가 , 하단 버튼 선택해서 커스텀해서 사용하기
							</div>
						</div>
						<!-- ui : table s -->
						<table class="table text-center">
							<caption class="sr-only">나눔 목록 테이블입니다.</caption>

							<colgroup>
								<col style="width:5%">
								<col style="width: 15%;">
								<col style="width: auto;">
								<col style="width: 15%;">
								<col style="width: 15%;">
								<col style="width: 15%;">
								<col style="width: 15%;">
							</colgroup>

							<thead>
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">나눔상태</th>
									<th scope="col">등록일</th>
									<th scope="col">수정일</th>
								</tr>
							</thead>
							<tbody>
								<!-- 일반 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000002</th>
									<td class="text-start">
										<!-- 새글일 때 new 클래스 추가 -->
										<a href="#" class="text-link d-flex new">
											<!-- icon new_icon 추가 -->
											<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
											<em class="text-elipsis">나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔
												게시판입니다.나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다. 나눔
												게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다.나눔
												게시판입니다.</em>
										</a>
									</td>
									<td>유길상</td>
									<td><span class="category share">나눔가능</span></td>
									<td>24.03.01</td>
									<td>24.03.01</td>
								</tr>
								<!-- 일반 -->
								<!-- new  -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000001</th>
									<td class="text-start">
										<a href="#" class="text-link d-flex ">
											<em class="text-elipsis">나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔
												게시판입니다.나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다. 나눔
												게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다.나눔
												게시판입니다.</em>
										</a>
									</td>
									<td>유길상</td>

									<td><span class="category disable">나눔완료</span></td>
									<td>24.03.01</td>
									<td>24.03.01</td>

								</tr>
								<!-- new -->

							</tbody>

						</table>
						<!-- 버튼 알아서 퍼가셈 -->
						<div class="btn-box clearfix mt-4">
							<div class="right float-end">
								<!-- <button class="btn btn-danger">취소</button> -->
								<button class="btn btn-danger">삭제</button>
								<button class="btn btn-primary">수정</button>
							</div>
						</div>
						<!-- 알아서 퍼가셈 -->
						<div class="btn-box clearfix mt-4">
							<div class="right float-end">
								<button class="btn btn-primary">등록</button>
							</div>
						</div>
						<!-- 버튼 알아서 퍼가셈 -->
						<!-- ui : table e -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
									<code data-clipboard-text="">
			<!-- Code Start -->
			&lt;!-- ui : table s -->
						&lt;table class="table text-center">
							&lt;caption class="sr-only">나눔 목록 테이블입니다.&lt;/caption>

							&lt;colgroup>
								&lt;col style="width:5%">
								&lt;col style="width: 15%;">
								&lt;col style="width: auto;">
								&lt;col style="width: 15%;">
								&lt;col style="width: 15%;">
								&lt;col style="width: 15%;">
								&lt;col style="width: 15%;">
							&lt;/colgroup>

							&lt;thead>
								&lt;tr>
									&lt;th>
										&lt;input type="checkbox">
									&lt;/th>
									&lt;th scope="col">번호&lt;/th>
									&lt;th scope="col">제목&lt;/th>
									&lt;th scope="col">작성자&lt;/th>
									&lt;th scope="col">나눔상태&lt;/th>
									&lt;th scope="col">등록일&lt;/th>
									&lt;th scope="col">수정일&lt;/th>
								&lt;/tr>
							&lt;/thead>
							&lt;tbody>
									&lt;!-- 일반 -->
									&lt;tr>
										&lt;th>
											&lt;input type="checkbox">
										&lt;/th>
										&lt;th scope="row">000002&lt;/th>
										&lt;td class="text-start">
											&lt;!-- 새글일 때 new 클래스 추가 -->
											&lt;a href="#" class="text-link d-flex new">
												&lt;!-- icon new_icon 추가 -->
												&lt;span class="icon new_icon">
													&lt;span class="sr-only">new&lt;/span>
												&lt;/span>
												&lt;em class="text-elipsis">나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다.&lt;/em>
											&lt;/a>
										&lt;/td>
										&lt;td>유길상&lt;/td>
										&lt;td>&lt;span class="category share">나눔가능&lt;/span>&lt;/td>
										&lt;td>24.03.01&lt;/td>
										&lt;td>24.03.01&lt;/td>
									&lt;/tr>
									&lt;!-- 일반 -->
								&lt;!-- new  -->
								&lt;tr>
									&lt;th>
										&lt;input type="checkbox">
									&lt;/th>
									&lt;th scope="row">000001&lt;/th>
									&lt;td class="text-start">
										&lt;a href="#" class="text-link d-flex ">
											&lt;em class="text-elipsis">나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다. 나눔 게시판입니다.나눔 게시판입니다.나눔 게시판입니다.&lt;/em>
										&lt;/a>
									&lt;/td>
									&lt;td>유길상&lt;/td>
									
									&lt;td>&lt;span class="category disable">나눔완료&lt;/span>&lt;/td>
									&lt;td>24.03.01&lt;/td>
									&lt;td>24.03.01&lt;/td>
									
								&lt;/tr>
								&lt;!-- new -->
							
							&lt;/tbody>

						&lt;/table>
						&lt;!-- 버튼 알아서 퍼가셈 -->
						&lt;div class="btn-box clearfix mt-4">
							&lt;div class="right float-end">
								&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
								&lt;button class="btn btn-danger">삭제&lt;/button>
								&lt;button class="btn btn-primary">수정&lt;/button>
							&lt;/div>
						&lt;/div>
						&lt;!-- 알아서 퍼가셈 -->
						&lt;div class="btn-box clearfix mt-4">
							&lt;div class="right float-end">
								&lt;button class="btn btn-primary">등록&lt;/button>
							&lt;/div>
						&lt;/div>
						&lt;!-- 버튼 알아서 퍼가셈 -->
						&lt;!-- ui : table e -->
			
			<!-- Code END -->
									</code>
								</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 05 커뮤니티게시판-->

		

			<!-- ui 05 페이지네이션-->
			<div class="ui"  id="ui09">
				<strong class="ui-tit p-4">페이지네이션</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- ui : page s -->
						<div class="pageBox">
							<ul class="pagination justify-content-center">
								<li class="page-item"><a class="page-link" href="#">Previous</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">Next</a></li>
							</ul>
						</div>

						<!-- ui : page e -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
									<code data-clipboard-text="">
			<!-- Code Start -->
			&lt;div class="pageBox">
			&lt;ul class="pagination justify-content-center">
				&lt;li class="page-item">&lt;a class="page-link" href="#">Previous&lt;/a>&lt;/li>
				&lt;li class="page-item">&lt;a class="page-link" href="#">1&lt;/a>&lt;/li>
				&lt;li class="page-item">&lt;a class="page-link" href="#">2&lt;/a>&lt;/li>
				&lt;li class="page-item">&lt;a class="page-link" href="#">3&lt;/a>&lt;/li>
				&lt;li class="page-item">&lt;a class="page-link" href="#">Next&lt;/a>&lt;/li>
			&lt;/ul>
		&lt;/div>
			
			<!-- Code END -->
									</code>
								</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 05 페이지네이션-->

			<!-- ui 05 캘린더-->
			<div class="ui"  id="ui10">
				<strong class="ui-tit p-4">캘린더</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<div class="calenderBox">
							<!-- 선택한 날짜 s -->
							<div class="col">
								<h2 class="text-start ui-tit">2022-07-17</h2>
							</div>
							<!-- 선택한 날짜 e -->
							<!-- calendar s -->
							<table class="calendar-list">
								<thead>
									<tr>
										<th scope="col"><span class="sunday">SUN</span></th>
										<th scope="col"><span>MON</span></th>
										<th scope="col"><span>TUE</span></th>
										<th scope="col"><span>WED</span></th>
										<th scope="col"><span>THUR</span></th>
										<th scope="col"><span>FRI</span></th>
										<th scope="col"><span class="saturday">SAT</span></th>
									</tr>
								</thead>
								<tbody id="calendarBody">
									<!-- 한 주 -->
									<tr>
										<td class="sunday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>1</span>
												</div>
												<div class="calendar-list__content">
													<div class="cal-today_box">
														<div class="cal-today_title">
															<span class="category all ">일감</span>
															<span class="totalNum fw-bold">15</span><span>건</span>
														</div>
														<ul class="cal-today_list">
															<li class="my-2">
																<span class="category emergency ">긴급</span>
																<span class="num text-danger fw-bold">8</span>
																<span>건</span>
															</li>
															<li>
																<span class="category ordinary">일반</span>
																<span class="num fw-bold">7</span>
																<span>건</span>
															</li>
														</ul>
														<button type="button" class="btn btn-primary mt-2 w-100"
															data-bs-toggle="modal"
															data-bs-target="#exampleModal">더보기</button>

													</div>
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>2</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>3</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>4</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>5</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>6</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="saturday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>7</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
									</tr>
									<!-- 한 주 -->
									<tr>
										<td class="sunday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>8</span>

												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>9</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>10</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>11</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>12</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>13</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="saturday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>14</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
									</tr>
									<!-- 한 주 -->
									<tr>
										<td class="sunday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>15</span>

												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>16</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>17</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>18</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>19</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>20</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="saturday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>21</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
									</tr>
									<!-- 한 주 -->
									<tr>
										<td class="sunday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>22</span>

												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>23</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>24</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>25</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>26</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>27</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="saturday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>28</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
									</tr>
									<!-- 한 주 -->
									<tr>
										<td class="sunday">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>29</span>

												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="">
											<div class="calendar-list__inner">
												<div class="calendar-list__day">
													<span>30</span>
												</div>
												<div class="calendar-list__content">
												</div>
											</div>
										</td>
										<td class="empty" data-start="5"></td>
										<td class="empty" data-start="5"></td>
										<td class="empty" data-start="5"></td>
										<td class="empty" data-start="5"></td>
										<td class="empty" data-start="5"></td>
									</tr>
								</tbody>
							</table>
							<!-- calendar e -->
							<!-- Modal s -->
							<div class="modal fade clanendarModal" id="exampleModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header bg-primary text-white">
											<strong class="modal-title" id="exampleModalLabel">일감 조회</strong>
										</div>
										<div class="modal-body">
											<!-- modal top -->
											<div class="cal-today_box cal-modal mb-3">

												<ul class="cal-today_list d-flex align-items-center">
													<li class="my-2">
														<span class="category all ">일감</span>
														<span class="totalNum fw-bold">15</span><span>건</span>
													</li>
													<li class="my-2">
														<span class="category emergency ">긴급</span>
														<span class="num text-danger fw-bold"> 7</span>
														<span>건</span>
													</li>
													<li class="my-2">
														<span class="category ordinary">일반</span>
														<span class="num fw-bold"> 8</span>
														<span>건</span>
													</li>
												</ul>
											</div>
											<!-- modal top -->
											<!-- modal bottom -->
											<div class="cal-Modal_table">

												<table class="table text-center">
													<caption class="sr-only">프로젝트 목록 테이블입니다.</caption>

													<colgroup>
														<col style="width: 5%;">
														<col style="width: 10%;">
														<col style="width: 10%;">
														<col style="width: auto;">
														<col style="width: 10%;">
														<col style="width: 8%;">
														<col style="width: 8%;">
														<col style="width: 8%;">
													</colgroup>

													<thead>
														<tr>
															<th scope="col">
																<input type="checkbox">
															</th>
															<th scope="col">번호</th>
															<th scope="col">상태</th>
															<th scope="col">제목</th>
															<th scope="col">담당자</th>
															<th scope="col">등록일</th>
															<th scope="col">마감일</th>
															<th scope="col">진행률</th>
														</tr>
													</thead>
													<tbody>
														<!-- 일감없음 -->
														<tr>
															<td class="text-center" colspan="8">분배된 일감이 없습니다</td>
														</tr>
														<!-- 일감없음 -->
														<!-- 긴급 -->
														<tr>
															<td><input type="checkbox"></td>
															<th scope="row">T000005</th>
															<td><span class="category emergency ">긴급</span></td>
															<td class="text-start">
																<a href="#" class="text-link d-flex">
																	<em class="text-elipsis">
																		배너 변경해주세요! 오전 열시까지요! 배너 변경해주세요! 오전 열시까지요!배너
																		변경해주세요!
																		오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전
																		열시까지요!배너
																		변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요!
																		오전
																		열시까지요!배너 변경해주세요! 오전 열시까지요!
																	</em>
																</a>
															</td>
															<td>유길상(개발1팀)</td>
															<td>24.01.01</td>
															<td>24.03.01</td>
															<td>
																<select class="form-select task-select">
																	<option value="" selected>0%</option>
																	<option value="10">10%</option>
																	<option value="30">30%</option>
																	<option value="30">30%</option>
																	<option value="50">50%</option>
																	<option value="70">70%</option>
																	<option value="90">90%</option>
																	<option value="99">90%</option>
																	<!-- 최종 검수자인 프로젝트매니저만 나옴 -->
																	<option value="100">100%</option>
																	<!-- 최종 검수자인 프로젝트매니저만 나옴 -->
																</select>
															</td>
														</tr>
														<!-- 긴급 -->
														<!-- 일반 -->
														<tr>
															<td><input type="checkbox"></td>
															<th scope="row">T000005</th>
															<td><span class="category ordinary ">일반</span></td>
															<td class="text-start">
																<a href="#" class="text-link d-flex">
																	<em class="text-elipsis">
																		배너 변경해주세요! 오전 열시까지요! 배너 변경해주세요! 오전 열시까지요!배너
																		변경해주세요!
																		오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전
																		열시까지요!배너
																		변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요!
																		오전
																		열시까지요!배너 변경해주세요! 오전 열시까지요!
																	</em>
																</a>
															</td>
															<td>유길상(개발1팀)</td>
															<td>24.01.01</td>
															<td>24.03.01</td>
															<td>
																<select class="form-select task-select">
																	<option value="" selected>0%</option>
																	<option value="10">10%</option>
																	<option value="30">30%</option>
																	<option value="30">30%</option>
																	<option value="50">50%</option>
																	<option value="70">70%</option>
																	<option value="90">90%</option>
																	<option value="99">90%</option>
																	<!-- 최종 검수자인 프로젝트매니저만 나옴 -->
																	<option value="100">100%</option>
																	<!-- 최종 검수자인 프로젝트매니저만 나옴 -->
																</select>
															</td>
														</tr>
														<!-- 일반 -->
													</tbody>

												</table>

												<!-- page -->

												<div class="pageBox">
													<ul class="pagination justify-content-center">
														<li class="page-item"><a class="page-link" href="#">Previous</a>
														</li>
														<li class="page-item"><a class="page-link" href="#">1</a></li>
														<li class="page-item"><a class="page-link" href="#">2</a></li>
														<li class="page-item"><a class="page-link" href="#">3</a></li>
														<li class="page-item"><a class="page-link" href="#">Next</a>
														</li>
													</ul>
												</div>
												<!-- page -->
											</div>
											<!-- modal bottom -->
										</div>
										<div class="modal-footer justify-content-center">
											<button type="button" class="btn btn-light btn-outline-secondary"
												data-bs-dismiss="modal">닫기</button>
											<button type="button" class="btn btn-primary"> 확인</button>
										</div>
									</div>
								</div>
							</div>
							<!-- modal e -->
						</div>
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->
		&lt;div class="calenderBox">
		&lt;!-- 선택한 날짜 s -->
		&lt;div class="col">
			&lt;h2 class="text-start ui-tit">2022-07-17&lt;/h2>
		&lt;/div>
		&lt;!-- 선택한 날짜 e -->
		&lt;!-- calendar s -->
		&lt;table class="calendar-list">
			&lt;thead>
				&lt;tr>
					&lt;th scope="col">&lt;span class="sunday">SUN&lt;/span>&lt;/th>
					&lt;th scope="col">&lt;span>MON&lt;/span>&lt;/th>
					&lt;th scope="col">&lt;span>TUE&lt;/span>&lt;/th>
					&lt;th scope="col">&lt;span>WED&lt;/span>&lt;/th>
					&lt;th scope="col">&lt;span>THUR&lt;/span>&lt;/th>
					&lt;th scope="col">&lt;span>FRI&lt;/span>&lt;/th>
					&lt;th scope="col">&lt;span class="saturday">SAT&lt;/span>&lt;/th>
				&lt;/tr>
			&lt;/thead>
			&lt;tbody id="calendarBody">
				&lt;!-- 한 주 -->
				&lt;tr>
					&lt;td class="sunday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>1&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
								&lt;div class="cal-today_box">
									&lt;div class="cal-today_title">
										&lt;span class="category all ">일감&lt;/span>
										&lt;span class="totalNum fw-bold">15&lt;/span>&lt;span>건&lt;/span> 
									&lt;/div>
									&lt;ul class="cal-today_list">
										&lt;li class="my-2">
											&lt;span class="category emergency ">긴급&lt;/span>
											&lt;span class="num text-danger fw-bold">8&lt;/span>
											&lt;span>건&lt;/span>
										&lt;/li>
										&lt;li>
											&lt;span class="category ordinary">일반&lt;/span>
											&lt;span class="num fw-bold">7&lt;/span>
											&lt;span>건&lt;/span>
										&lt;/li>
									&lt;/ul>
									&lt;button type="button" class="btn btn-primary mt-2 w-100" data-bs-toggle="modal" data-bs-target="#exampleModal">더보기&lt;/button>
								
								&lt;/div>
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>2&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>3&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>4&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>5&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>6&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="saturday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>7&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
				&lt;/tr>
				&lt;!-- 한 주 -->
				&lt;tr>
					&lt;td class="sunday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>8&lt;/span>

							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>9&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>10&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>11&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>12&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>13&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="saturday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>14&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
				&lt;/tr>
				&lt;!-- 한 주 -->
				&lt;tr>
					&lt;td class="sunday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>15&lt;/span>

							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>16&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>17&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>18&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>19&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>20&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="saturday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>21&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
				&lt;/tr>
				&lt;!-- 한 주 -->
				&lt;tr>
					&lt;td class="sunday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>22&lt;/span>

							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>23&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>24&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>25&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>26&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>27&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="saturday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>28&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
				&lt;/tr>
				&lt;!-- 한 주 -->
				&lt;tr>
					&lt;td class="sunday">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>29&lt;/span>

							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="">
						&lt;div class="calendar-list__inner">
							&lt;div class="calendar-list__day">
								&lt;span>30&lt;/span>
							&lt;/div>
							&lt;div class="calendar-list__content">
							&lt;/div>
						&lt;/div>
					&lt;/td>
					&lt;td class="empty" data-start="5">&lt;/td>
					&lt;td class="empty" data-start="5">&lt;/td>
					&lt;td class="empty" data-start="5">&lt;/td>
					&lt;td class="empty" data-start="5">&lt;/td>
					&lt;td class="empty" data-start="5">&lt;/td>
				&lt;/tr>
			&lt;/tbody>
		&lt;/table>
		&lt;!-- calendar e -->
		&lt;!-- Modal s -->
		&lt;div class="modal fade clanendarModal" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			&lt;div class="modal-dialog modal-lg">
				&lt;div class="modal-content">
					&lt;div class="modal-header bg-primary text-white">
						&lt;strong class="modal-title" id="exampleModalLabel">일감 조회&lt;/strong>
					&lt;/div>
					&lt;div class="modal-body">
						&lt;!-- modal top -->
						&lt;div class="cal-today_box cal-modal mb-3">
						
							&lt;ul class="cal-today_list d-flex align-items-center">
								&lt;li class="my-2"> 
									&lt;span class="category all ">일감&lt;/span>
									&lt;span class="totalNum fw-bold">15&lt;/span>&lt;span>건&lt;/span> 
								&lt;/li>
								&lt;li class="my-2">
									&lt;span class="category emergency ">긴급&lt;/span>
									&lt;span class="num text-danger fw-bold"> 7&lt;/span>
									&lt;span>건&lt;/span>
								&lt;/li>
								&lt;li class="my-2">
									&lt;span class="category ordinary">일반&lt;/span>
									&lt;span class="num fw-bold"> 8&lt;/span>
									&lt;span>건&lt;/span>
								&lt;/li>
							&lt;/ul>
						&lt;/div>
						&lt;!-- modal top -->
						&lt;!-- modal bottom -->
						&lt;div class="cal-Modal_table">

							&lt;table class="table text-center">
								&lt;caption class="sr-only">프로젝트 목록 테이블입니다.&lt;/caption>

								&lt;colgroup>
									&lt;col style="width: 5%;">
									&lt;col style="width: 10%;">
									&lt;col style="width: 10%;">
									&lt;col style="width: auto;">
									&lt;col style="width: 10%;">
									&lt;col style="width: 8%;">
									&lt;col style="width: 8%;">
									&lt;col style="width: 8%;">
								&lt;/colgroup>

								&lt;thead>
									&lt;tr>
										&lt;th scope="col">
											&lt;input type="checkbox">
										&lt;/th>
										&lt;th scope="col">번호&lt;/th>
										&lt;th scope="col">상태&lt;/th>
										&lt;th scope="col">제목&lt;/th>
										&lt;th scope="col">담당자&lt;/th>
										&lt;th scope="col">등록일&lt;/th>
										&lt;th scope="col">마감일&lt;/th>
										&lt;th scope="col">진행률&lt;/th>
									&lt;/tr>
								&lt;/thead>
								&lt;tbody>
									&lt;!-- 일감없음 -->
									&lt;tr>
										&lt;td class="text-center" colspan="8">분배된 일감이 없습니다&lt;/td>
									&lt;/tr>
									&lt;!-- 일감없음 -->
									&lt;!-- 긴급 -->
									&lt;tr>
										&lt;td>&lt;input type="checkbox">&lt;/td>
										&lt;th scope="row">T000005&lt;/th>
										&lt;td>&lt;span class="category emergency ">긴급&lt;/span>&lt;/td>
										&lt;td class="text-start">
											&lt;a href="#" class="text-link d-flex">
												&lt;em class="text-elipsis">
											배너 변경해주세요! 오전 열시까지요! 배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!
											&lt;/em>
											&lt;/a>
										&lt;/td>
										&lt;td>유길상(개발1팀)&lt;/td>
										&lt;td>24.01.01&lt;/td>
										&lt;td>24.03.01&lt;/td>
										&lt;td>
											&lt;select class="form-select task-select">
											&lt;option value="" selected>0%&lt;/option>
											&lt;option value="10">10%&lt;/option>
											&lt;option value="30">30%&lt;/option>
											&lt;option value="30">30%&lt;/option>
											&lt;option value="50">50%&lt;/option>
											&lt;option value="70">70%&lt;/option>
											&lt;option value="90">90%&lt;/option>
											&lt;option value="99">90%&lt;/option>
											&lt;!-- 최종 검수자인 프로젝트매니저만 나옴 -->
											&lt;option value="100">100%&lt;/option>
											&lt;!-- 최종 검수자인 프로젝트매니저만 나옴 -->
											&lt;/select>
										&lt;/td>
									&lt;/tr>
									&lt;!-- 긴급 -->
									&lt;!-- 일반 -->
									&lt;tr>
										&lt;td>&lt;input type="checkbox">&lt;/td>
										&lt;th scope="row">T000005&lt;/th>
										&lt;td>&lt;span class="category ordinary ">일반&lt;/span>&lt;/td>
										&lt;td class="text-start">
											&lt;a href="#" class="text-link d-flex">
												&lt;em class="text-elipsis">
											배너 변경해주세요! 오전 열시까지요! 배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!배너 변경해주세요! 오전 열시까지요!
											&lt;/em>
											&lt;/a>
										&lt;/td>
										&lt;td>유길상(개발1팀)&lt;/td>
										&lt;td>24.01.01&lt;/td>
										&lt;td>24.03.01&lt;/td>
										&lt;td>
											&lt;select class="form-select task-select">
											&lt;option value="" selected>0%&lt;/option>
											&lt;option value="10">10%&lt;/option>
											&lt;option value="30">30%&lt;/option>
											&lt;option value="30">30%&lt;/option>
											&lt;option value="50">50%&lt;/option>
											&lt;option value="70">70%&lt;/option>
											&lt;option value="90">90%&lt;/option>
											&lt;option value="99">90%&lt;/option>
											&lt;!-- 최종 검수자인 프로젝트매니저만 나옴 -->
											&lt;option value="100">100%&lt;/option>
											&lt;!-- 최종 검수자인 프로젝트매니저만 나옴 -->
											&lt;/select>
										&lt;/td>
									&lt;/tr>
									&lt;!-- 일반 -->
								&lt;/tbody>

							&lt;/table>	

							&lt;!-- page -->
								
							&lt;div class="pageBox">
								&lt;ul class="pagination justify-content-center">
									&lt;li class="page-item">&lt;a class="page-link" href="#">Previous&lt;/a>&lt;/li>
									&lt;li class="page-item">&lt;a class="page-link" href="#">1&lt;/a>&lt;/li>
									&lt;li class="page-item">&lt;a class="page-link" href="#">2&lt;/a>&lt;/li>
									&lt;li class="page-item">&lt;a class="page-link" href="#">3&lt;/a>&lt;/li>
									&lt;li class="page-item">&lt;a class="page-link" href="#">Next&lt;/a>&lt;/li>
								&lt;/ul>
							&lt;/div>
							&lt;!-- page -->
						&lt;/div>
						&lt;!-- modal bottom -->
					&lt;/div>
					&lt;div class="modal-footer justify-content-center">
						&lt;button type="button" class="btn btn-light btn-outline-secondary" data-bs-dismiss="modal">닫기&lt;/button>
						&lt;button type="button" class="btn btn-primary"> 확인&lt;/button>
					&lt;/div>
				&lt;/div>
			&lt;/div>
		&lt;/div>
		&lt;!-- modal e -->
		&lt;/div>

		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 05 캘린더-->

			<!-- ui 댓글-->
			<div class="ui" id="ui11">
				<strong class="ui-tit p-4">댓글</strong>

				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- comment UI -->
						<!-- commentForm -->
						<form class="comment mb-5">
							<legend class="comment-tit">댓글쓰기</legend>
							<div class="card bg-light">
								<div class="card-body comment-body">
									<!-- comment list -->
									<div class="comment-list">
										<ul class="ul depth1 clearfix">
											<li class="li">
												<div class="depth-row">
													<div class="comment-content">
														<div class="imgbox">
															<div class="img-in no-img">
																<!-- no-img일때  -->
																<img src="./resources/images/prog/navi.jpg"
																	alt="작성자프로필이미지">
																<!-- no-img일때  -->
															</div>
														</div>
														<div class="writebox">
															<span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고
																싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요</span>
														</div>


													</div>
													<div class="comment-info d-flex justify-content-between">

														<div class="left  d-flex ">
															<span class="comment-writer">
																<i class="icon writer"></i>
																<em>유길상(개발1팀)</em>
															</span>
															<span class="comment-date  ms-4">
																<i class="icon date"></i>2024.01.03</span>


														</div>
														<button type="button" class="btn btn-danger ms-1"
															data-bs-toggle="modal"
															data-bs-target="#exampleModal">삭제</button>
													</div>
												</div>
												<!-- depth2 -->
												<ul class="ul depth2 border-top">
													<li>
														<div class="depth-row">
															<div class="comment-content">
																<div class="imgbox">
																	<div class="img-in no-img">
																		<!-- no-img일때  -->
																		<img src="./resources/images/prog/navi.jpg"
																			alt="작성자프로필이미지">
																		<!-- no-img일때  -->
																	</div>
																</div>
																<div class="writebox">
																	<span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																		집에가고 싶어요
																		집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																		집에가고 싶어요
																		집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																		집에가고 싶어요
																		집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																		집에가고 싶어요
																		집에가고 싶어요
																		집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																		집에가고 싶어요
																		집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																		집에가고 싶어요
																		집에가고 싶어요</span>
																</div>

															</div>
														</div>
														<div class="comment-info d-flex justify-content-between">

															<div class="left  d-flex ">
																<span class="comment-writer">
																	<i class="icon writer"></i>
																	<em>유길상(개발1팀)</em>
																</span>
																<span class="comment-date  ms-4">
																	<i class="icon date"></i>2024.01.03</span>


															</div>
															<button type="button" class="btn btn-danger ms-1"
																data-bs-toggle="modal"
																data-bs-target="#exampleModal">삭제</button>
														</div>
													</li>

												</ul>
												<!-- depth2 -->
											</li>
											<li class="li border-top">
												<div class="depth-row">
													<div class="comment-content">
														<div class="imgbox">
															<div class="img-in no-img">
																<!-- no-img일때  -->
																<img src="./resources/images/prog/navi.jpg"
																	alt="작성자프로필이미지">
																<!-- no-img일때  -->
															</div>
														</div>
														<div class="writebox">
															<span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고
																싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																집에가고 싶어요</span>
														</div>

													</div>
													<div class="comment-info d-flex justify-content-between">

														<div class="left  d-flex ">
															<span class="comment-writer">
																<i class="icon writer"></i>
																<em>유길상(개발1팀)</em>
															</span>
															<span class="comment-date  ms-4">
																<i class="icon date"></i>2024.01.03</span>
														</div>
														<button type="button" class="btn btn-danger ms-1"
															data-bs-toggle="modal"
															data-bs-target="#exampleModal">삭제</button>
													</div>
												</div>
											</li>
										</ul>

									</div>
									<!-- comment list -->
									<!-- comment-input -->
									<div class="d-flex mb-4 comment-input">
										<!-- 아이디값은 달라야함 -->
										<label for="textarea1"><span class="sr-only">댓글입력창</span></label>
										<textarea class="form-control" rows="5" placeholder="댓글을 입력해주세요"
											id="textarea1"></textarea>
										<input class="btn btn-secondary register" type="submit" value="등록">
										<!-- 아이디값은 달라야함 -->
									</div>
									<!-- comment-input -->

								</div>
							</div>
						</form>
						<!-- Modal -->
						<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
							aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
										<button type="button" class="btn-close" data-bs-dismiss="modal"
											aria-label="Close"></button>
									</div>
									<div class="modal-body">
										"댓글을 삭제하시겠습니까?"
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">닫기</button>
										<button type="button" class="btn btn-primary">확인</button>
									</div>
								</div>
							</div>
						</div>
						<!-- modal -->
						<!-- commentForm -->

						<!-- comment UI -->
					</div>
					<!-- ui : e -->
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->
		&lt;!-- commentForm -->
		&lt;form class="comment mb-5">
			&lt;legend class="comment-tit">댓글쓰기&lt;/legend>
			&lt;div class="card bg-light">
				&lt;div class="card-body comment-body">
					&lt;!-- comment list -->
					&lt;div class="comment-list">
						&lt;ul class="ul depth1 clearfix">
							&lt;li class="li">
								&lt;div class="depth-row">
									&lt;div class="comment-content">
										&lt;div class="imgbox">
											&lt;div class="img-in no-img">
												&lt;!-- no-img일때  -->
												&lt;img src="./resources/images/prog/navi.jpg"
													alt="작성자프로필이미지">
												&lt;!-- no-img일때  -->
											&lt;/div>
										&lt;/div>
										&lt;div class="writebox">
											&lt;span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고
												싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요&lt;/span>
										&lt;/div>


									&lt;/div>
									&lt;div class="comment-info d-flex justify-content-between">

										&lt;div class="left  d-flex ">
											&lt;span class="comment-writer">
												&lt;i class="icon writer">&lt;/i>
												&lt;em>유길상(개발1팀)&lt;/em>
											&lt;/span>
											&lt;span class="comment-date  ms-4">
												&lt;i class="icon date">&lt;/i>2024.01.03&lt;/span>


										&lt;/div>
										&lt;button type="button" class="btn btn-danger ms-1"
											data-bs-toggle="modal"
											data-bs-target="#exampleModal">삭제&lt;/button>
									&lt;/div>
								&lt;/div>
								&lt;!-- depth2 -->
								&lt;ul class="ul depth2 border-top">
									&lt;li>
										&lt;div class="depth-row">
											&lt;div class="comment-content">
												&lt;div class="imgbox">
													&lt;div class="img-in no-img">
														&lt;!-- no-img일때  -->
														&lt;img src="./resources/images/prog/navi.jpg"
															alt="작성자프로필이미지">
														&lt;!-- no-img일때  -->
													&lt;/div>
												&lt;/div>
												&lt;div class="writebox">
													&lt;span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요&lt;/span>
												&lt;/div>

											&lt;/div>
										&lt;/div>
										&lt;div class="comment-info d-flex justify-content-between">

											&lt;div class="left  d-flex ">
												&lt;span class="comment-writer">
													&lt;i class="icon writer">&lt;/i>
													&lt;em>유길상(개발1팀)&lt;/em>
												&lt;/span>
												&lt;span class="comment-date  ms-4">
													&lt;i class="icon date">&lt;/i>2024.01.03&lt;/span>


											&lt;/div>
											&lt;button type="button" class="btn btn-danger ms-1"
												data-bs-toggle="modal"
												data-bs-target="#exampleModal">삭제&lt;/button>
										&lt;/div>
									&lt;/li>

								&lt;/ul>
								&lt;!-- depth2 -->
							&lt;/li>
							&lt;li class="li border-top">
								&lt;div class="depth-row">
									&lt;div class="comment-content">
										&lt;div class="imgbox">
											&lt;div class="img-in no-img">
												&lt;!-- no-img일때  -->
												&lt;img src="./resources/images/prog/navi.jpg"
													alt="작성자프로필이미지">
												&lt;!-- no-img일때  -->
											&lt;/div>
										&lt;/div>
										&lt;div class="writebox">
											&lt;span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고
												싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요&lt;/span>
										&lt;/div>

									&lt;/div>
									&lt;div class="comment-info d-flex justify-content-between">

										&lt;div class="left  d-flex ">
											&lt;span class="comment-writer">
												&lt;i class="icon writer">&lt;/i>
												&lt;em>유길상(개발1팀)&lt;/em>
											&lt;/span>
											&lt;span class="comment-date  ms-4">
												&lt;i class="icon date">&lt;/i>2024.01.03&lt;/span>
										&lt;/div>
										&lt;button type="button" class="btn btn-danger ms-1"
											data-bs-toggle="modal"
											data-bs-target="#exampleModal">삭제&lt;/button>
									&lt;/div>
								&lt;/div>
							&lt;/li>
						&lt;/ul>

					&lt;/div>
					&lt;!-- comment list -->
					&lt;!-- comment-input -->
					&lt;div class="d-flex mb-4 comment-input">
						&lt;label for="textarea">&lt;span class="sr-only">댓글입력창&lt;/span>&lt;/label>
						&lt;textarea class="form-control" rows="5" placeholder="댓글을 입력해주세요"
							id="textarea">&lt;/textarea>
						&lt;input class="btn btn-secondary register" type="submit" value="등록">
					&lt;/div>
					&lt;!-- comment-input -->

				&lt;/div>
			&lt;/div>
		&lt;/form>
		&lt;!-- Modal -->
		&lt;div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
			aria-hidden="true">
			&lt;div class="modal-dialog">
				&lt;div class="modal-content">
					&lt;div class="modal-header">
						&lt;strong class="modal-title fs-5" id="exampleModalLabel">안내&lt;/strong>
						&lt;button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close">&lt;/button>
					&lt;/div>
					&lt;div class="modal-body">
						"댓글을 삭제하시겠습니까?"
					&lt;/div>
					&lt;div class="modal-footer">
						&lt;button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기&lt;/button>
						&lt;button type="button" class="btn btn-primary">확인&lt;/button>
					&lt;/div>
				&lt;/div>
			&lt;/div>
		&lt;/div>
		&lt;!-- modal -->
		&lt;!-- commentForm -->
		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 댓글-->

			<!-- ui 02 마이페이지(비밀번호인증)-->
			<div class="ui" id="ui12">
				<strong class="ui-tit p-4">마이페이지(비밀번호인증)</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- mypagePW -->
						<div class="mypage">
							<div class="box">

								<div class="mypage-login">
									<strong class="tit">인증로그인</strong>
									<div class="imgbox">
										<div class="img-in">
											<img src="./resources/images/prog/navi.jpg" alt="작성자프로필이미지">
											<!-- <img src="./resources/images/prog/TA.png" alt="작성자프로필이미지"> -->
										</div>
									</div>

									<div class="input-info">
										<div class="mb-1">

											<input type="text" title="사원번호를 입력해주세요." placeholder="사원번호를 입력해주세요."
												class="form-control" id="id" name="id" autocomplete="off" required=""
												aria-required="true">
										</div>
										<div class="mb-1">
											<input type="password" title="비밀번호를 입력해주세요." placeholder="비밀번호를 입력해주세요."
												class="form-control" id="password" name="password" autocomplete="off"
												required="" aria-required="true">
										</div>
										<button type="submit" class="btn btn-login btn-custom">로그인</button>
									</div>

								</div>

							</div>
						</div>
						<!-- mypagePW -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
									<code data-clipboard-text="">
			<!-- Code Start -->
			&lt;div class="mypage">
			&lt;div class="box">

				&lt;div class="mypage-login">
					&lt;strong class="tit">인증로그인&lt;/strong>
					&lt;div class="imgbox">
						&lt;div class="img-in">
							&lt;img src="./resources/images/prog/navi.jpg" alt="작성자프로필이미지">
							&lt;!-- &lt;img src="./resources/images/prog/TA.png" alt="작성자프로필이미지"> -->
						&lt;/div>
					&lt;/div>

					&lt;div class="input-info">
						&lt;div class="mb-1">

							&lt;input type="text" title="사원번호를 입력해주세요." placeholder="사원번호를 입력해주세요." class="form-control" id="id"
								name="id" autocomplete="off" required="" aria-required="true">
						&lt;/div>
						&lt;div class="mb-1">
							&lt;input type="password" title="비밀번호를 입력해주세요." placeholder="비밀번호를 입력해주세요." class="form-control"
								id="password" name="password" autocomplete="off" required="" aria-required="true">
						&lt;/div>
						&lt;button type="submit" class="btn btn-login btn-custom">로그인&lt;/button>
					&lt;/div>

				&lt;/div>

			&lt;/div>
		&lt;/div>	
			<!-- Code END -->
									</code>
								</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 02 마이페이지(비밀번호인증)-->

			<!-- ui 03 사원권한관리(관리자)-->
			<div class="ui"  id="ui13">
				<strong class="ui-tit p-4"> 사원권한관리(관리자)</strong>

				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<div class="row my-3">
							<div class="col-12">
								1) 카테고리는 그대로 쓰면됨<br>
								2) 테이블 컬럼명변경 및 컬럼 추가 , 하단 버튼 선택해서 커스텀해서 사용하기
								3) - 조회리스트 (체크박스,권한상태(부여,미부여 [전환되는 버튼]), 사원ID, 이름, 직급 , 주소, 휴대번호, 이메일, 입사년도)<br>
								- 조회리스트 (체크박스,차단상태(상태, 차단 [전환되는 버튼]), 사원ID, 이름, 직급 , 주소, 휴대번호, 이메일, 입사년도)
							</div>
						</div>
						<!-- ui : table s -->
						<table class="table text-center">
							<caption class="sr-only">사원 권한관리 테이블입니다.</caption>

							<colgroup>
								<col style="width:5%">
								<col style="width: 15%;">
								<col style="width: 8%;">
								<col style="width: 8%;">
								<col style="width: 8%;">
								<col style="width: auto;">
								<col style="width: 10%;">
								<col style="width: 10%;">
								<col style="width: 10%;">
							</colgroup>

							<thead>
								<tr>
									<th>
										<input type="checkbox">
									</th>

									<th scope="col">사원ID</th>
									<th scope="col">이름</th>
									<th scope="col">직급</th>
									<th scope="col">권한</th>
									<th scope="col">주소</th>
									<th scope="col">휴대번호</th>
									<th scope="col">이메일</th>
									<th scope="col">입사년도</th>
								</tr>
							</thead>
							<tbody>
								<!-- 일반 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000002</th>
									<td>유길상</td>
									<td>부장</td>
									<td>
										<span class="category permission">승인</span>
									</td>
									<td class="text-start">
										<em class="text-elipsis">대전광역시 오류동 124 뷔릴A 404동 112호</em>
									</td>
									<td>010-1234-1234</td>
									<td>24.03.01</td>
									<td>24.03.01</td>

								</tr>
								<!-- 일반 -->
								<!-- 일반 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000001</th>

									<td>정민지</td>
									<td>사원</td>
									<td><span class="category deny">해제</span></td>
									<td class="text-start">
										<em class="text-elipsis">대전광역시 오류동 피엠에스A OOO동 OOO호</em>
									<td>010-1234-1234</td>
									<td>24.03.01</td>
									<td>24.03.01</td>


									</td>

								</tr>
								<!-- 일반 -->
								<!-- 일반 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000001</th>

									<td>우민규</td>
									<td>사원</td>
									<td><span class="category deny">차단</span></td>
									<td class="text-start">
										<em class="text-elipsis">대전광역시 오류동 피엠에스A OOO동 OOO호</em>
									<td>010-1234-1234</td>
									<td>24.03.01</td>
									<td>24.03.01</td>

									</td>

								</tr>
								<!-- 일반 -->


							</tbody>

						</table>
						<!-- 버튼 알아서 퍼가셈 -->
						<div class="btn-box clearfix mt-4">
							<div class="right float-end">
								<!-- <button class="btn btn-danger">취소</button> -->
								<button class="btn btn-danger">권한해제</button>
								<button class="btn btn-primary">권한부여</button>
							</div>
						</div>
						<!-- 알아서 퍼가셈 -->
						<div class="btn-box clearfix mt-4">
							<div class="right float-end">
								<button class="btn btn-primary">초대</button>
							</div>
						</div>
						<!-- 버튼 알아서 퍼가셈 -->
						<!-- 알아서 퍼가셈 -->
						<div class="btn-box clearfix mt-4">
							<div class="right float-end">
								<button class="btn btn-danger">삭제</button>
								<button class="btn btn-primary">차단</button>
							</div>
						</div>
						<!-- 버튼 알아서 퍼가셈 -->
						<!-- 알아서 퍼가셈 -->
						<div class="btn-box clearfix mt-4">
							<div class="right float-end">
								<!-- 차단해제 -->
								<button class="btn btn-primary">해제</button>
								<!-- 차단해제 -->
							</div>
						</div>
						<!-- 버튼 알아서 퍼가셈 -->
						<!-- ui : table e -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->
		&lt;!-- ui : table s -->
		&lt;table class="table text-center">
			&lt;caption class="sr-only">사원 권한관리 테이블입니다.&lt;/caption>

			&lt;colgroup>
				&lt;col style="width:5%">
				&lt;col style="width: 15%;">
				&lt;col style="width: 8%;">
				&lt;col style="width: 8%;">
				&lt;col style="width: 8%;">
				&lt;col style="width: auto;">
				&lt;col style="width: 10%;">
				&lt;col style="width: 10%;">
				&lt;col style="width: 10%;">
			&lt;/colgroup>

			&lt;thead>
				&lt;tr>
					&lt;th>
						&lt;input type="checkbox">
					&lt;/th>
			
					&lt;th scope="col">사원ID&lt;/th>
					&lt;th scope="col">이름&lt;/th>
					&lt;th scope="col">직급&lt;/th>
					&lt;th scope="col">권한&lt;/th>
					&lt;th scope="col">주소&lt;/th>
					&lt;th scope="col">휴대번호&lt;/th>
					&lt;th scope="col">이메일&lt;/th>
					&lt;th scope="col">입사년도&lt;/th>
				&lt;/tr>
			&lt;/thead>
			&lt;tbody>
					&lt;!-- 일반 -->
					&lt;tr>
						&lt;th>
							&lt;input type="checkbox">
						&lt;/th>
						&lt;th scope="row">000002&lt;/th>
						&lt;td>유길상&lt;/td>
						&lt;td>부장&lt;/td>
						&lt;td>
							&lt;span class="category permission">승인&lt;/span>
						&lt;/td>
						&lt;td class="text-start">
							&lt;em class="text-elipsis">대전광역시 오류동 124 뷔릴A 404동 112호&lt;/em>
						&lt;/td>
						&lt;td>010-1234-1234&lt;/td>
						&lt;td>24.03.01&lt;/td>
						&lt;td>24.03.01&lt;/td>
						
					&lt;/tr>
					&lt;!-- 일반 -->
					&lt;!-- 일반 -->
					&lt;tr>
						&lt;th>
							&lt;input type="checkbox">
						&lt;/th>
						&lt;th scope="row">000001&lt;/th>
						
						&lt;td>정민지&lt;/td>
						&lt;td>사원&lt;/td>
						&lt;td>&lt;span class="category deny">해제&lt;/span>&lt;/td>
						&lt;td class="text-start">
							&lt;em class="text-elipsis">대전광역시 오류동 피엠에스A OOO동 OOO호&lt;/em>
						&lt;td>010-1234-1234&lt;/td>
						&lt;td>24.03.01&lt;/td>
						&lt;td>24.03.01&lt;/td>
					
						
					&lt;/td>
						
					&lt;/tr>
					&lt;!-- 일반 -->
						&lt;!-- 일반 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">000001&lt;/th>
							
							&lt;td>우민규&lt;/td>
							&lt;td>사원&lt;/td>
							&lt;td>&lt;span class="category deny">차단&lt;/span>&lt;/td>
							&lt;td class="text-start">
								&lt;em class="text-elipsis">대전광역시 오류동 피엠에스A OOO동 OOO호&lt;/em>
							&lt;td>010-1234-1234&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
							
						&lt;/td>
							
						&lt;/tr>
						&lt;!-- 일반 -->
					
				
			&lt;/tbody>

		&lt;/table>
		&lt;!-- 버튼 알아서 퍼가셈 -->
		&lt;div class="btn-box clearfix mt-4">
			&lt;div class="right float-end">
				&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
				&lt;button class="btn btn-danger">권한해제&lt;/button>
				&lt;button class="btn btn-primary">권한부여&lt;/button>
			&lt;/div>
		&lt;/div>
		&lt;!-- 알아서 퍼가셈 -->
		&lt;div class="btn-box clearfix mt-4">
			&lt;div class="right float-end">
				&lt;button class="btn btn-primary">초대&lt;/button>
			&lt;/div>
		&lt;/div>
		&lt;!-- 버튼 알아서 퍼가셈 -->
		&lt;!-- 알아서 퍼가셈 -->
			&lt;div class="btn-box clearfix mt-4">
				&lt;div class="right float-end">
					&lt;button class="btn btn-danger">삭제&lt;/button>
					&lt;button class="btn btn-primary">차단&lt;/button>
				&lt;/div>
			&lt;/div>
			&lt;!-- 버튼 알아서 퍼가셈 -->
			&lt;!-- 알아서 퍼가셈 -->
			&lt;div class="btn-box clearfix mt-4">
				&lt;div class="right float-end">
					&lt;!-- 차단해제 -->
					&lt;button class="btn btn-primary">해제&lt;/button>
					&lt;!-- 차단해제 -->
				&lt;/div>
			&lt;/div>
			&lt;!-- 버튼 알아서 퍼가셈 -->
	&lt;!-- ui : table e -->

		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 03 사원권한관리(관리자)-->

			<!-- ui 프로젝트 게시판 -->
			<div class="ui"  id="ui14">
				<strong class="ui-tit p-4">프로젝트게시판</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- ui : table s -->
						<div class="row my-3">
							<div class="col-12">
								1) 관리자 게시판은 전부 기본테이블 형식으로 진행<br>
								2) 테이블 컬럼명변경 및 컬럼 추가 , 하단 버튼 선택해서 커스텀해서 사용하기
								3) -조회리스트 (체크박스, 번호, 프로젝트ID, 상태, 프로젝트명, 관리자, 등록일,마감예정일) / 삭제버튼<br>
								- 조회리스트 (체크박스, 번호, 프로젝트ID, 상태, 프로젝트명, 관리자, 등록일,마감예정일) / 복구 버튼
							</div>
						</div>

						<table class="table text-center">
							<caption class="sr-only">프로젝트 목록 테이블입니다.</caption>

							<colgroup>
								<col style="width: 5%;">
								<col style="width: 10%;">
								<col style="width: 8%;">
								<col style="width: 8%;">
								<col style="width: auto;">
								<col style="width: 10%;">
								<col style="width: 8%;">
								<col style="width: 10%;">
								<col style="width: 10%;">
								<col style="width: 115px;">
							</colgroup>

							<thead>
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="col">번호</th>
									<th scope="col">프로젝트ID</th>
									<th scope="col">상태</th>
									<th scope="col">프로젝트명</th>
									<th scope="col">작성자</th>
									<th scope="col">첨부파일</th>
									<th scope="col">등록일</th>
									<th scope="col">마감일</th>
									<th scope="col">위키이동</th>
								</tr>
							</thead>
							<tbody>
								<!-- 1 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000007</th>
									<td>P000007</td>
									<td><span class="category ordinary">안정</span></td>
									<td class="text-start"><a href="#" class="text-link d-flex new">

											<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
											<em class="text-elipsis">프로젝트 게시판입니다. 프로젝트 게시판입니다. 프로젝트 게시판입니다. 프로젝트 게시판입니다.
												프로젝트
												게시판입니다.프로젝트 게시판입니다. 프로젝트 게시판입니다.프로젝트 게시판입니다.프로젝트 게시판입니다.프로젝트 게시판입니다.
												프로젝트
												게시판입니다. 프로젝트 게시판입니다. 프로젝트 게시판입니다. 프로젝트 게시판입니다.프로젝트 게시판입니다. 프로젝트
												게시판입니다.프로젝트
												게시판입니다.프로젝트 게시판입니다.</em>
										</a>
									</td>
									<td>유길상</td>
									<td>
										<a href="" class="download_link" download=""><i class="icon hangle"></i><em
												class="sr-only">한글파일 다운로드</em></a>
									</td>
									<td>24.01.01</td>
									<td>24.03.01</td>

									<td><button type="button" class="btn btn-primary">위키등록</button></td>
								</tr>
								<!-- 1 -->
								<!-- 2 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000006</th>
									<td>P000006</td>
									<td><span class="category emergency">긴급</span></td>
									<td class="text-start"><a href="#" class="text-link d-flex">
											<span class="icon new_icon"><span class="sr-only">new</span></span>
											<em class="text-elipsis">프로젝트 게시판입니다.프로젝트 게시판입니다.</em>
										</a>
									</td>
									<td>유길상</td>
									<td>
										<a href="" class="download_link" download=""><i class="icon xlsx"></i><em
												class="sr-only">엑셀파일 다운로드</em></a>

									</td>
									<td>24.01.01</td>
									<td>24.03.01</td>
									<td><button type="button" class="btn btn-secondary" disabled="">위키등록</button></td>
								</tr>
								<!-- 2 -->
								<!-- 3 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">000003</th>
									<td>P000003</td>
									<td><span class="category project">신규</span></td>
									<td class="text-start"><a href="#" class="text-link d-flex new">

											<span class="icon new_icon"><span class="sr-only">new</span></span>
											<em class="text-elipsis">프로젝트 게시판입니다.프로젝트 게시판입니다.</em>
										</a>
									<td>유길상</td>
									<td>
										<a href="" class="download_link" download=""><i class="icon ppt"></i><em
												class="sr-only">파워포인트파일 다운로드</em></a>
									</td>
									<td>24.01.01</td>
									<td>24.03.01</td>
									<td><button type="button" class="btn btn-primary">위키등록</button></td>
								</tr>
								<!-- 3 -->
								<!-- 4 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">004</th>
									<td>BA</td>
									<td><span class="category ordinary">안정</span></td>
									<td class="text-start">
										<a href="#" class="text-link d-flex">
											프로젝트입니다
										</a>
									</td>
									<td>유길상</td>
									<td><a href="" class="download_link" download=""><i class="icon txt"></i><em
												class="sr-only">텍스트파일 다운로드</em></a>
									</td>
									<td>24.01.01</td>
									<td>24.03.01</td>
									<td><button type="button" class="btn btn-primary">위키등록</button></td>
								</tr>
								<!-- 4 -->
								<!-- 5 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">005</th>
									<td>BA</td>
									<td><span class="category ordinary">안정</span></td>
									<td class="text-start">
										<a href="#" class="text-link d-flex">
											프로젝트입니다
										</a>
									</td>
									<td>유길상</td>
									<td>
										<a href="" class="download_link" download=""><i class="icon pdf"></i><em
												class="sr-only">pdf 다운로드</em></a>
									</td>
									<td>24.01.01</td>
									<td>24.03.01</td>
									<td><button type="button" class="btn btn-primary">위키등록</button></td>

								</tr>
								<!-- 5 -->
								<!-- 6 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">005</th>
									<td>BA</td>
									<td><span class="category ordinary">안정</span></td>
									<td class="text-start">
										<a href="#" class="text-link d-flex">
											프로젝트입니다22222
										</a>
									</td>
									<td>유길상</td>
									<td>
										<a href="" class="download_link" download=""><i class="icon zip"></i><em
												class="sr-only">zip 다운로드</em></a>
									</td>
									<td>24.01.01</td>
									<td>24.03.01</td>
									<td><button type="button" class="btn btn-primary">위키등록</button></td>
								</tr>
								<!-- 6 -->
								<!-- 7 -->
								<tr>
									<th>
										<input type="checkbox">
									</th>
									<th scope="row">005</th>
									<td>BA</td>
									<td><span class="category ordinary">안정</span></td>
									<td class="text-start">
										<a href="#" class="text-link d-flex">
											프로젝트입니다22222
										</a>
									</td>
									<td>유길상</td>
									<td>
										<a href="" class="download_link" download=""><i class="icon word"></i><em
												class="sr-only">word 다운로드</em></a>
									</td>
									<td>24.01.01</td>
									<td>24.03.01</td>
									<td><button type="button" class="btn btn-primary">위키등록</button></td>
								</tr>
								<!-- 7 -->
							</tbody>
						</table>
						<!-- ui : table e -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
										<code data-clipboard-text="">
				<!-- Code Start -->
				&lt;!-- ui : table s -->
				&lt;table class="table text-center">
					&lt;caption class="sr-only">프로젝트 목록 테이블입니다.&lt;/caption>

					&lt;colgroup>
						&lt;col style="width: 5%;">
						&lt;col style="width: 10%;">
						&lt;col style="width: 8%;">
						&lt;col style="width: auto;">
						&lt;col style="width: 10%;">
						&lt;col style="width: 10%;">
						&lt;col style="width: 8%;">
						&lt;col style="width: 10%;">
						&lt;col style="width: 10%;">

					&lt;/colgroup>

					&lt;thead>
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="col">번호&lt;/th>
							&lt;th scope="col">프로젝트ID&lt;/th>
							&lt;th scope="col">상태&lt;/th>
							&lt;th scope="col">프로젝트명&lt;/th>
							&lt;th scope="col">작성자&lt;/th>
							&lt;th scope="col">첨부파일&lt;/th>
							&lt;th scope="col">등록일&lt;/th>
							&lt;th scope="col">마감일&lt;/th>
							&lt;th scope="col">위키이동&lt;/th>
						&lt;/tr>
					&lt;/thead>
					&lt;tbody>
						&lt;!-- 1 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">000007&lt;/th>
							&lt;td>P000007&lt;/td>
							&lt;td>&lt;span class="category ordinary">안정&lt;/span>&lt;/td>
							&lt;td class="text-start">&lt;a href="#" class="text-link d-flex new">

									&lt;span class="icon new_icon">
										&lt;span class="sr-only">new&lt;/span>
									&lt;/span>
									&lt;em class="text-elipsis">프로젝트 게시판입니다. 프로젝트 게시판입니다. 프로젝트 게시판입니다. 프로젝트 게시판입니다. 프로젝트
										게시판입니다.프로젝트 게시판입니다. 프로젝트 게시판입니다.프로젝트 게시판입니다.프로젝트 게시판입니다.프로젝트 게시판입니다. 프로젝트
										게시판입니다. 프로젝트 게시판입니다. 프로젝트 게시판입니다. 프로젝트 게시판입니다.프로젝트 게시판입니다. 프로젝트 게시판입니다.프로젝트
										게시판입니다.프로젝트 게시판입니다.&lt;/em>
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>
								&lt;a href="" class="download_link" download="">&lt;i class="icon hangle">&lt;/i>&lt;em
										class="sr-only">한글파일 다운로드&lt;/em>&lt;/a>
							&lt;/td>
							&lt;td>24.01.01&lt;/td>
							&lt;td>24.03.01&lt;/td>

							&lt;td>&lt;button type="button" class="btn btn-primary">위키등록&lt;/button>&lt;/td>
						&lt;/tr>
						&lt;!-- 1 -->
						&lt;!-- 2 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">000006&lt;/th>
							&lt;td>P000006&lt;/td>
							&lt;td>&lt;span class="category emergency">긴급&lt;/span>&lt;/td>
							&lt;td class="text-start">&lt;a href="#" class="text-link d-flex">
									&lt;span class="icon new_icon">&lt;span class="sr-only">new&lt;/span>&lt;/span>
									&lt;em class="text-elipsis">프로젝트 게시판입니다.프로젝트 게시판입니다.&lt;/em>
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>
								&lt;a href="" class="download_link" download="">&lt;i class="icon xlsx">&lt;/i>&lt;em
										class="sr-only">엑셀파일 다운로드&lt;/em>&lt;/a>

							&lt;/td>
							&lt;td>24.01.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>&lt;button type="button" class="btn btn-secondary" disabled="">위키등록&lt;/button>&lt;/td>
						&lt;/tr>
						&lt;!-- 2 -->
						&lt;!-- 3 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">000003&lt;/th>
							&lt;td>P000003&lt;/td>
							&lt;td>&lt;span class="category project">신규&lt;/span>&lt;/td>
							&lt;td class="text-start">&lt;a href="#" class="text-link d-flex new">

									&lt;span class="icon new_icon">&lt;span class="sr-only">new&lt;/span>&lt;/span>
									&lt;em class="text-elipsis">프로젝트 게시판입니다.프로젝트 게시판입니다.&lt;/em>
								&lt;/a>
							&lt;td>유길상&lt;/td>
							&lt;td>
								&lt;a href="" class="download_link" download="">&lt;i class="icon ppt">&lt;/i>&lt;em
										class="sr-only">파워포인트파일 다운로드&lt;/em>&lt;/a>
							&lt;/td>
							&lt;td>24.01.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>&lt;button type="button" class="btn btn-primary">위키등록&lt;/button>&lt;/td>
						&lt;/tr>
						&lt;!-- 3 -->
						&lt;!-- 4 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">004&lt;/th>
							&lt;td>BA&lt;/td>
							&lt;td>&lt;span class="category ordinary">안정&lt;/span>&lt;/td>
							&lt;td class="text-start">
								&lt;a href="#" class="text-link d-flex">
									프로젝트입니다
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>&lt;a href="" class="download_link" download="">&lt;i class="icon txt">&lt;/i>&lt;em
										class="sr-only">텍스트파일 다운로드&lt;/em>&lt;/a>
							&lt;/td>
							&lt;td>24.01.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>&lt;button type="button" class="btn btn-primary">위키등록&lt;/button>&lt;/td>
						&lt;/tr>
						&lt;!-- 4 -->
						&lt;!-- 5 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">005&lt;/th>
							&lt;td>BA&lt;/td>
							&lt;td>&lt;span class="category ordinary">안정&lt;/span>&lt;/td>
							&lt;td class="text-start">
								&lt;a href="#" class="text-link d-flex">
									프로젝트입니다
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>
								&lt;a href="" class="download_link" download="">&lt;i class="icon pdf">&lt;/i>&lt;em
										class="sr-only">pdf 다운로드&lt;/em>&lt;/a>
							&lt;/td>
							&lt;td>24.01.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>&lt;button type="button" class="btn btn-primary">위키등록&lt;/button>&lt;/td>

						&lt;/tr>
						&lt;!-- 5 -->
						&lt;!-- 6 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">005&lt;/th>
							&lt;td>BA&lt;/td>
							&lt;td>&lt;span class="category ordinary">안정&lt;/span>&lt;/td>
							&lt;td class="text-start">
								&lt;a href="#" class="text-link d-flex">
									프로젝트입니다22222
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>
								&lt;a href="" class="download_link" download="">&lt;i class="icon zip">&lt;/i>&lt;em
										class="sr-only">zip 다운로드&lt;/em>&lt;/a>
							&lt;/td>
							&lt;td>24.01.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>&lt;button type="button" class="btn btn-primary">위키등록&lt;/button>&lt;/td>
						&lt;/tr>
						&lt;!-- 6 -->
						&lt;!-- 7 -->
						&lt;tr>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th scope="row">005&lt;/th>
							&lt;td>BA&lt;/td>
							&lt;td>&lt;span class="category ordinary">안정&lt;/span>&lt;/td>
							&lt;td class="text-start">
								&lt;a href="#" class="text-link d-flex">
									프로젝트입니다22222
								&lt;/a>
							&lt;/td>
							&lt;td>유길상&lt;/td>
							&lt;td>
								&lt;a href="" class="download_link" download="">&lt;i class="icon word">&lt;/i>&lt;em
										class="sr-only">word 다운로드&lt;/em>&lt;/a>
							&lt;/td>
							&lt;td>24.01.01&lt;/td>
							&lt;td>24.03.01&lt;/td>
							&lt;td>&lt;button type="button" class="btn btn-primary">위키등록&lt;/button>&lt;/td>
						&lt;/tr>
						&lt;!-- 7 -->	
					&lt;/tbody>
				&lt;/table>
				&lt;!-- ui : table e -->
				<!-- Code END -->
										</code>
									</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 프로젝트 게시판 -->

			<!-- ui03 프로젝트상세-->
			<div class="ui" id="ui15">
				<strong class="ui-tit p-4">프로젝트상세</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- project veiw -->
						<div class="view">
							<div class="view_inner">
								<div class="view-info">
									<strong class="view-tit">
										<span class="category project">P00001</span> <em>2024대덕인재개발원 리뉴얼</em></strong>
									<ul class="ul clearfix">

										<li><span class="list-tit">담당자</span><span>유길상 (개발2팀)</span></li>
										<li><span class="list-tit">진행기간</span><span>2024.04.05</span></li>
										<li><span class="list-tit">마감일</span><span>2024.04.05</span></li>
										<li><span class="list-tit">등록일</span><span>2024.04.05</span></li>
										<li><span class="list-tit">수정일</span><span>2024.04.05</span></li>
										<li><span class="list-tit">상&emsp;태</span><span>신규</span></li>
										<!-- 프로젝트 상태값:
														<li><span class="">상태</span><span>신규</span></li>
														<li><span class="">상태</span><span>안정</span></li>
														<li><span class="">상태</span><span>긴급</span></li>
												-->
									</ul>
								</div>
								<div class="view_content">
									프로젝트상세입니다

								</div>
							</div>

						</div>
						<!-- project veiw -->
						<!-- button -->
						<div class="btn-box clearfix mt-4">
							<button class="btn btn-secondary">목록</button>
							<div class="right float-end">
								<!-- <button class="btn btn-danger">취소</button> -->
								<button class="btn btn-danger">삭제</button>
								<button class="btn btn-primary">수정</button>
							</div>
						</div>
						<!-- button -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
									<code data-clipboard-text="">
			<!-- Code Start -->
		
			&lt;!-- project veiw -->
			&lt;div class="view">
				&lt;div class="view_inner">
					&lt;div class="view-info">
						&lt;strong class="view-tit">
							&lt;span class="category project">P00001&lt;/span> &lt;em>2024대덕인재개발원 리뉴얼&lt;/em>&lt;/strong>
						&lt;ul class="ul clearfix">
						
							&lt;li>&lt;span class="list-tit">담당자&lt;/span>&lt;span>유길상 (개발2팀)&lt;/span>&lt;/li>
							&lt;li>&lt;span class="list-tit">진행기간&lt;/span>&lt;span>2024.04.05&lt;/span>&lt;/li>
							&lt;li>&lt;span class="list-tit">마감일&lt;/span>&lt;span>2024.04.05&lt;/span>&lt;/li>
							&lt;li>&lt;span class="list-tit">등록일&lt;/span>&lt;span>2024.04.05&lt;/span>&lt;/li>
							&lt;li>&lt;span class="list-tit">수정일&lt;/span>&lt;span>2024.04.05&lt;/span>&lt;/li>
							&lt;li>&lt;span class="list-tit">상&emsp;태&lt;/span>&lt;span>신규&lt;/span>&lt;/li>
							&lt;!-- 프로젝트 상태값:
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>신규&lt;/span>&lt;/li>
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>안정&lt;/span>&lt;/li>
									&lt;li>&lt;span class="">상태&lt;/span>&lt;span>긴급&lt;/span>&lt;/li>
							-->
						&lt;/ul>
					&lt;/div>
					&lt;div class="view_content">


					&lt;/div>
				&lt;/div>

			&lt;/div>
			&lt;!-- project veiw -->
			&lt;!-- button -->
			&lt;div class="btn-box clearfix mt-4">
				&lt;button class="btn btn-secondary">목록&lt;/button>
				&lt;div class="right float-end">
					&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
					&lt;button class="btn btn-danger">삭제&lt;/button>
					&lt;button class="btn btn-primary">수정&lt;/button>
				&lt;/div>
			&lt;/div>
		&lt;!-- button -->

			<!-- Code END -->
									</code>
								</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui03 프로젝트상세-->


			<!-- ui 05 포토공간목록-->
			<div class="ui" id="ui16">
				<strong class="ui-tit p-4">포토공간목록</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- ui : 포토공간목록 s -->
						<div class="row row-cols-1 row-cols-md-4 g-4 photo_list">
							<!-- col -->
							<div class="col">
								<div class="card">
									<div class="photo_img">
										<div class="img-in no-img">
											<img src="./resources/images/prog/navi.jpg" class="card-img-top" alt="">
										</div>
									</div>
									<div class="card-body">
										<strong class="card-title">
											<em class="text-elipsis">영화보러간날 영화보러 간 날 영화보러간날 영화보러 간 날영화보러간날 영화보러 간
												날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러
												간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날</em>
										</strong>
										<button class="kinBtn border-0">
											<i class="icon kin"></i>
											<i class="sr-only">즐겨찾기버튼</i>
										</button>
									</div>
									<ul class="card-footer d-flex justify-content-between border-0 py-0">
										<li>
											<button class="likeBtn active border-0"><i class="icon like"><em
														class="sr-only">좋아요</em></i>999k</button>
										</li>
										<li>
											<span><i class="icon writer"><em class="sr-only">작성자</em></i>
												정민지
											</span>
										</li>
										<li>
											<span><i class="icon date"><em class="sr-only">날짜</em></i>24.05.04
											</span>
										</li>
									</ul>
								</div>
							</div>
							<!-- col -->
							<!-- col -->
							<div class="col">
								<div class="card">
									<div class="photo_img">
										<div class="img-in no-img">
											<img src="./resources/images/prog/navi.jpg" class="card-img-top" alt="">
										</div>
									</div>
									<div class="card-body">
										<strong class="card-title">
											<em class="text-elipsis">영화보러간날 영화보러 간 날 영화보러간날 영화보러 간 날영화보러간날 영화보러 간
												날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러
												간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날</em>
										</strong>
										<button class="kinBtn border-0">
											<i class="icon kin"></i>
											<i class="sr-only">즐겨찾기버튼</i>
										</button>
									</div>
									<ul class="card-footer d-flex justify-content-between border-0 py-0">
										<li>
											<button class="likeBtn active border-0"><i class="icon like"><em
														class="sr-only">좋아요</em></i>999k</button>
										</li>
										<li>
											<span><i class="icon writer"><em class="sr-only">작성자</em></i>
												정민지
											</span>
										</li>
										<li>
											<span><i class="icon date"><em class="sr-only">날짜</em></i>24.05.04
											</span>
										</li>
									</ul>
								</div>
							</div>
							<!-- col -->
							<!-- col -->
							<div class="col">
								<div class="card">
									<div class="photo_img">
										<div class="img-in no-img">
											<img src="./resources/images/prog/navi.jpg" class="card-img-top" alt="">
										</div>
									</div>
									<div class="card-body">
										<strong class="card-title">
											<em class="text-elipsis">영화보러간날 영화보러 간 날 영화보러간날 영화보러 간 날영화보러간날 영화보러 간
												날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러
												간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날</em>
										</strong>
										<button class="kinBtn border-0">
											<i class="icon kin"></i>
											<i class="sr-only">즐겨찾기버튼</i>
										</button>
									</div>
									<ul class="card-footer d-flex justify-content-between border-0 py-0">
										<li>
											<button class="likeBtn active border-0"><i class="icon like"><em
														class="sr-only">좋아요</em></i>999k</button>
										</li>
										<li>
											<span><i class="icon writer"><em class="sr-only">작성자</em></i>
												정민지
											</span>
										</li>
										<li>
											<span><i class="icon date"><em class="sr-only">날짜</em></i>24.05.04
											</span>
										</li>
									</ul>
								</div>
							</div>
							<!-- col -->
							<!-- col -->
							<div class="col">
								<div class="card">
									<div class="photo_img">
										<div class="img-in no-img">
											<img src="./resources/images/prog/navi.jpg" class="card-img-top" alt="">
										</div>
									</div>
									<div class="card-body">
										<strong class="card-title">
											<em class="text-elipsis">영화보러간날 영화보러 간 날 영화보러간날 영화보러 간 날영화보러간날 영화보러 간
												날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러
												간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날</em>
										</strong>
										<button class="kinBtn border-0">
											<i class="icon kin"></i>
											<i class="sr-only">즐겨찾기버튼</i>
										</button>
									</div>
									<ul class="card-footer d-flex justify-content-between border-0 py-0">
										<li>
											<button class="likeBtn active border-0"><i class="icon like"><em
														class="sr-only">좋아요</em></i>999k</button>
										</li>
										<li>
											<span><i class="icon writer"><em class="sr-only">작성자</em></i>
												정민지
											</span>
										</li>
										<li>
											<span><i class="icon date"><em class="sr-only">날짜</em></i>24.05.04
											</span>
										</li>
									</ul>
								</div>
							</div>
							<!-- col -->
						</div>
						<!-- 스크립트 넣기  -->
						<script>

							//like,kin 버튼 클릭 시 .active 클래스 토글 , 
							//kin은 저정
							//like 는 클릭횟수에 대한 숫자증가

						</script>
						<!-- 스크립트 넣기  -->
						<!-- ui : 포토공간목록 e -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->
		&lt;!-- ui : 포토공간목록 s -->
&lt;div class="row row-cols-1 row-cols-md-4 g-4 photo_list">
	&lt;!-- col -->
	&lt;div class="col">
		&lt;div class="card">
			&lt;div class="photo_img">
				&lt;div class="img-in no-img">
					&lt;img src="./resources/images/prog/navi.jpg" class="card-img-top" alt="">
				&lt;/div>
			&lt;/div>
			&lt;div class="card-body">
				&lt;strong class="card-title">
				&lt;em class="text-elipsis">영화보러간날 영화보러 간 날 영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날&lt;/em>
				&lt;/strong>
				&lt;button class="kinBtn border-0">
					&lt;i class="icon kin">&lt;/i>
					&lt;i class="sr-only">즐겨찾기버튼&lt;/i>
				&lt;/button>
			&lt;/div>
			&lt;ul class="card-footer d-flex justify-content-between border-0 py-0">
				&lt;li>
					&lt;button class="likeBtn active border-0">&lt;i class="icon like">&lt;em class="sr-only">좋아요&lt;/em>&lt;/i>999k&lt;/button>
				&lt;/li>
				&lt;li>
					&lt;span>&lt;i class="icon writer">&lt;em class="sr-only">작성자&lt;/em>&lt;/i>
					정민지
					&lt;/span>
				&lt;/li>
				&lt;li>
					&lt;span>&lt;i class="icon date">&lt;em class="sr-only">날짜&lt;/em>&lt;/i>24.05.04
					&lt;/span>
				&lt;/li>
			&lt;/ul>
		&lt;/div>
	&lt;/div>
	&lt;!-- col -->
	&lt;!-- col -->
	&lt;div class="col">
		&lt;div class="card">
			&lt;div class="photo_img">
				&lt;div class="img-in no-img">
					&lt;img src="./resources/images/prog/navi.jpg" class="card-img-top" alt="">
				&lt;/div>
			&lt;/div>
			&lt;div class="card-body">
				&lt;strong class="card-title">
				&lt;em class="text-elipsis">영화보러간날 영화보러 간 날 영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날&lt;/em>
				&lt;/strong>
				&lt;button class="kinBtn border-0">
					&lt;i class="icon kin">&lt;/i>
					&lt;i class="sr-only">즐겨찾기버튼&lt;/i>
				&lt;/button>
			&lt;/div>
			&lt;ul class="card-footer d-flex justify-content-between border-0 py-0">
				&lt;li>
					&lt;button class="likeBtn active border-0">&lt;i class="icon like">&lt;em class="sr-only">좋아요&lt;/em>&lt;/i>999k&lt;/button>
				&lt;/li>
				&lt;li>
					&lt;span>&lt;i class="icon writer">&lt;em class="sr-only">작성자&lt;/em>&lt;/i>
					정민지
					&lt;/span>
				&lt;/li>
				&lt;li>
					&lt;span>&lt;i class="icon date">&lt;em class="sr-only">날짜&lt;/em>&lt;/i>24.05.04
					&lt;/span>
				&lt;/li>
			&lt;/ul>
		&lt;/div>
	&lt;/div>
	&lt;!-- col -->
	&lt;!-- col -->
	&lt;div class="col">
		&lt;div class="card">
			&lt;div class="photo_img">
				&lt;div class="img-in no-img">
					&lt;img src="./resources/images/prog/navi.jpg" class="card-img-top" alt="">
				&lt;/div>
			&lt;/div>
			&lt;div class="card-body">
				&lt;strong class="card-title">
				&lt;em class="text-elipsis">영화보러간날 영화보러 간 날 영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날&lt;/em>
				&lt;/strong>
				&lt;button class="kinBtn border-0">
					&lt;i class="icon kin">&lt;/i>
					&lt;i class="sr-only">즐겨찾기버튼&lt;/i>
				&lt;/button>
			&lt;/div>
			&lt;ul class="card-footer d-flex justify-content-between border-0 py-0">
				&lt;li>
					&lt;button class="likeBtn active border-0">&lt;i class="icon like">&lt;em class="sr-only">좋아요&lt;/em>&lt;/i>999k&lt;/button>
				&lt;/li>
				&lt;li>
					&lt;span>&lt;i class="icon writer">&lt;em class="sr-only">작성자&lt;/em>&lt;/i>
					정민지
					&lt;/span>
				&lt;/li>
				&lt;li>
					&lt;span>&lt;i class="icon date">&lt;em class="sr-only">날짜&lt;/em>&lt;/i>24.05.04
					&lt;/span>
				&lt;/li>
			&lt;/ul>
		&lt;/div>
	&lt;/div>
	&lt;!-- col -->
		&lt;!-- col -->
		&lt;div class="col">
			&lt;div class="card">
				&lt;div class="photo_img">
					&lt;div class="img-in no-img">
						&lt;img src="./resources/images/prog/navi.jpg" class="card-img-top" alt="">
					&lt;/div>
				&lt;/div>
				&lt;div class="card-body">
					&lt;strong class="card-title">
					&lt;em class="text-elipsis">영화보러간날 영화보러 간 날 영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날영화보러간날 영화보러 간 날&lt;/em>
					&lt;/strong>
					&lt;button class="kinBtn border-0">
						&lt;i class="icon kin">&lt;/i>
						&lt;i class="sr-only">즐겨찾기버튼&lt;/i>
					&lt;/button>
				&lt;/div>
				&lt;ul class="card-footer d-flex justify-content-between border-0 py-0">
					&lt;li>
						&lt;button class="likeBtn active border-0">&lt;i class="icon like">&lt;em class="sr-only">좋아요&lt;/em>&lt;/i>999k&lt;/button>
					&lt;/li>
					&lt;li>
						&lt;span>&lt;i class="icon writer">&lt;em class="sr-only">작성자&lt;/em>&lt;/i>
						정민지
						&lt;/span>
					&lt;/li>
					&lt;li>
						&lt;span>&lt;i class="icon date">&lt;em class="sr-only">날짜&lt;/em>&lt;/i>24.05.04
						&lt;/span>
					&lt;/li>
				&lt;/ul>
			&lt;/div>
		&lt;/div>
		&lt;!-- col -->
&lt;/div>
&lt;!-- 스크립트 넣기  -->
&lt;script>
	//like,kin 버튼 클릭 시 .active 클래스 토글 , 
	//kin은 저정
	//like 는 클릭횟수에 대한 숫자증가

&lt;/script>
&lt;!-- 스크립트 넣기  -->
&lt;!-- ui : 포토공간목록 e -->
		
		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 05 포토공간목록-->

			<!-- ui 05 포토공간상세-->
			<div class="ui" id="ui17">
				<strong class="ui-tit p-4">포토공간목록</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- ui : 포토공간목록 s -->

						<!-- project veiw -->
						<div class="view">
							<div class="view_inner">
								<div class="view-info">
									<strong class="view-tit icon-tit">
										<span class="icon photo"></span>
										<em>2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원
											리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼</em></strong>
									<ul class="ul clearfix">

										<li><span class="list-tit">작성자</span><span>유길상 (개발2팀)</span></li>
										<li><span class="list-tit">등록일</span><span>2024.04.05</span></li>

									</ul>
								</div>
								<div class="view_content">

									영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
									영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
									영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
									영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
									영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
									<!-- img  -->
									<div class="photo-view_img">
										<strong class="d-flex align-items-center"> <i class="icon camera"></i>첨부된
											이미지</strong>
										<div class="">
											<ul class="scroll_x my-2 py-3">
												<!-- item -->
												<li class="photo-img_item">
													<div class="img-in">
														<img src="https://via.placeholder.com/150"
															class="img-thumbnail me-2" alt="이미지1">
													</div>
												</li>
												<!-- item -->
												<!-- item -->
												<li class="photo-img_item">
													<div class="img-in">
														<img src="https://via.placeholder.com/150"
															class="img-thumbnail me-2" alt="이미지1">
													</div>
												</li>
												<!-- item -->
												<!-- item -->
												<li class="photo-img_item">
													<div class="img-in">
														<img src="https://via.placeholder.com/150"
															class="img-thumbnail me-2" alt="이미지1">
													</div>
												</li>
												<!-- item -->
												<!-- item -->
												<li class="photo-img_item">
													<div class="img-in">
														<img src="https://via.placeholder.com/150"
															class="img-thumbnail me-2" alt="이미지1">
													</div>
												</li>
												<!-- item -->
												<!-- item -->
												<li class="photo-img_item">
													<div class="img-in">
														<img src="https://via.placeholder.com/150"
															class="img-thumbnail me-2" alt="이미지1">
													</div>
												</li>
												<!-- item -->
												<!-- item -->
												<li class="photo-img_item">
													<div class="img-in">
														<img src="https://via.placeholder.com/150"
															class="img-thumbnail me-2" alt="이미지1">
													</div>
												</li>
												<!-- item -->
												<!-- item -->
												<li class="photo-img_item">
													<div class="img-in">
														<img src="https://via.placeholder.com/150"
															class="img-thumbnail me-2" alt="이미지1">
													</div>
												</li>
												<!-- item -->
												<!-- item -->
												<li class="photo-img_item">
													<div class="img-in">
														<img src="https://via.placeholder.com/150"
															class="img-thumbnail me-2" alt="이미지1">
													</div>
												</li>
												<!-- item -->
										</div>
									</div>
									<!-- img -->
								</div>
							</div>
							<!-- commentForm -->
							<form class="comment mb-5">
								<legend class="comment-tit">댓글쓰기</legend>
								<div class="card bg-light">
									<div class="card-body comment-body">
										<!-- comment list -->
										<div class="comment-list">
											<ul class="ul depth1 clearfix">
												<li class="li">
													<div class="depth-row">
														<div class="comment-content">
															<div class="imgbox">
																<div class="img-in no-img">
																	<!-- no-img일때  -->
																	<img src="./resources/images/prog/navi.jpg"
																		alt="작성자프로필이미지">
																	<!-- no-img일때  -->
																</div>
															</div>
															<div class="writebox">
																<span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요</span>
															</div>


														</div>
														<div class="comment-info d-flex justify-content-between">

															<div class="left  d-flex ">
																<span class="comment-writer">
																	<i class="icon writer"></i>
																	<em>유길상(개발1팀)</em>
																</span>
																<span class="comment-date  ms-4">
																	<i class="icon date"></i>2024.01.03</span>


															</div>
															<button type="button" class="btn btn-danger ms-1"
																data-bs-toggle="modal"
																data-bs-target="#exampleModal">삭제</button>
														</div>
													</div>
													<!-- depth2 -->
													<ul class="ul depth2 border-top">
														<li>
															<div class="depth-row">
																<div class="comment-content">
																	<div class="imgbox">
																		<div class="img-in no-img">
																			<!-- no-img일때  -->
																			<img src="./resources/images/prog/navi.jpg"
																				alt="작성자프로필이미지">
																			<!-- no-img일때  -->
																		</div>
																	</div>
																	<div class="writebox">
																		<span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																			싶어요
																			집에가고 싶어요
																			집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																			집에가고 싶어요
																			집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																			집에가고 싶어요
																			집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																			집에가고 싶어요
																			집에가고 싶어요
																			집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																			집에가고 싶어요
																			집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
																			집에가고 싶어요
																			집에가고 싶어요</span>
																	</div>

																</div>
															</div>
															<div class="comment-info d-flex justify-content-between">

																<div class="left  d-flex ">
																	<span class="comment-writer">
																		<i class="icon writer"></i>
																		<em>유길상(개발1팀)</em>
																	</span>
																	<span class="comment-date  ms-4">
																		<i class="icon date"></i>2024.01.03</span>


																</div>
																<button type="button" class="btn btn-danger ms-1"
																	data-bs-toggle="modal"
																	data-bs-target="#exampleModal">삭제</button>
															</div>
														</li>

													</ul>
													<!-- depth2 -->
												</li>
												<li class="li border-top">
													<div class="depth-row">
														<div class="comment-content">
															<div class="imgbox">
																<div class="img-in no-img">
																	<!-- no-img일때  -->
																	<img src="./resources/images/prog/navi.jpg"
																		alt="작성자프로필이미지">
																	<!-- no-img일때  -->
																</div>
															</div>
															<div class="writebox">
																<span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고
																	싶어요
																	집에가고 싶어요</span>
															</div>

														</div>
														<div class="comment-info d-flex justify-content-between">

															<div class="left  d-flex ">
																<span class="comment-writer">
																	<i class="icon writer"></i>
																	<em>유길상(개발1팀)</em>
																</span>
																<span class="comment-date  ms-4">
																	<i class="icon date"></i>2024.01.03</span>
															</div>
															<button type="button" class="btn btn-danger ms-1"
																data-bs-toggle="modal"
																data-bs-target="#exampleModal">삭제</button>
														</div>
													</div>
												</li>
											</ul>

										</div>
										<!-- comment list -->
										<!-- comment-input -->
										<div class="d-flex mb-4 comment-input w-100">
											<label for="textarea"><span class="sr-only">댓글입력창</span></label>
											<textarea class="form-control" rows="5" placeholder="댓글을 입력해주세요"
												id="textarea"></textarea>
											<input class="btn btn-secondary register" type="submit" value="등록">
										</div>
										<!-- comment-input -->

									</div>
								</div>
							</form>
							<!-- commentForm -->
							<!-- Modal -->
							<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
											<button type="button" class="btn-close" data-bs-dismiss="modal"
												aria-label="Close"></button>
										</div>
										<div class="modal-body">
											"댓글을 삭제하시겠습니까?"
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">닫기</button>
											<button type="button" class="btn btn-primary">확인</button>
										</div>
									</div>
								</div>
							</div>
							<!-- modal -->
							<!-- commentForm -->

						</div>

					</div>
					<!-- project veiw -->
					<!-- button -->
					<div class="btn-box clearfix mt-4">
						<button class="btn btn-secondary">목록</button>
						<div class="right float-end">
							<!-- <button class="btn btn-danger">취소</button> -->
							<button class="btn btn-danger">삭제</button>
							<button class="btn btn-primary">수정</button>
						</div>
					</div>
					<!-- button -->
					<!-- ui : 포토공간목록 e -->
					<!-- ui : e -->
				</div>
				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
								<code data-clipboard-text="">
		<!-- Code Start -->
		&lt;!-- ui : 포토공간목록 s -->

		&lt;!-- project veiw -->
		&lt;div class="view">
			&lt;div class="view_inner">
				&lt;div class="view-info">
					&lt;strong class="view-tit icon-tit">
						&lt;span class="icon photo">&lt;/span>
						&lt;em>2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼 2024대덕인재개발원 리뉴얼&lt;/em>&lt;/strong>
					&lt;ul class="ul clearfix">
					
						&lt;li>&lt;span class="list-tit">작성자&lt;/span>&lt;span>유길상 (개발2팀)&lt;/span>&lt;/li>
						&lt;li>&lt;span class="list-tit">등록일&lt;/span>&lt;span>2024.04.05&lt;/span>&lt;/li>
					
					&lt;/ul>
				&lt;/div>
				&lt;div class="view_content">
	
					영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
					영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
					영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
					영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
					영화보러간 날 집에 가고 싶다. 잠이나 자고 싶다,영화가 넘 재미가 없다.
					&lt;!-- img  -->
					&lt;div class="photo-view_img">
						&lt;strong class="d-flex align-items-center"> &lt;i class="icon camera">&lt;/i>첨부된 이미지&lt;/strong>
						&lt;div class="">
							&lt;ul class="scroll_x my-2 py-3">
								&lt;!-- item -->
								&lt;li class="photo-img_item">
									&lt;div class="img-in">
										&lt;img src="https://via.placeholder.com/150" class="img-thumbnail me-2" alt="이미지1">
									&lt;/div>
								&lt;/li>
								&lt;!-- item -->
								&lt;!-- item -->
								&lt;li class="photo-img_item">
									&lt;div class="img-in">
										&lt;img src="https://via.placeholder.com/150" class="img-thumbnail me-2" alt="이미지1">
									&lt;/div>
								&lt;/li>
								&lt;!-- item -->
								&lt;!-- item -->
								&lt;li class="photo-img_item">
									&lt;div class="img-in">
										&lt;img src="https://via.placeholder.com/150" class="img-thumbnail me-2" alt="이미지1">
									&lt;/div>
								&lt;/li>
								&lt;!-- item -->
								&lt;!-- item -->
								&lt;li class="photo-img_item">
									&lt;div class="img-in">
										&lt;img src="https://via.placeholder.com/150" class="img-thumbnail me-2" alt="이미지1">
									&lt;/div>
								&lt;/li>
								&lt;!-- item -->
								&lt;!-- item -->
								&lt;li class="photo-img_item">
									&lt;div class="img-in">
										&lt;img src="https://via.placeholder.com/150" class="img-thumbnail me-2" alt="이미지1">
									&lt;/div>
								&lt;/li>
								&lt;!-- item -->
								&lt;!-- item -->
								&lt;li class="photo-img_item">
									&lt;div class="img-in">
										&lt;img src="https://via.placeholder.com/150" class="img-thumbnail me-2" alt="이미지1">
									&lt;/div>
								&lt;/li>
								&lt;!-- item -->
									&lt;!-- item -->
									&lt;li class="photo-img_item">
										&lt;div class="img-in">
											&lt;img src="https://via.placeholder.com/150" class="img-thumbnail me-2" alt="이미지1">
										&lt;/div>
									&lt;/li>
									&lt;!-- item -->
									&lt;!-- item -->
									&lt;li class="photo-img_item">
										&lt;div class="img-in">
											&lt;img src="https://via.placeholder.com/150" class="img-thumbnail me-2" alt="이미지1">
										&lt;/div>
									&lt;/li>
									&lt;!-- item -->
						&lt;/div>
					&lt;/div>
					&lt;!-- img -->
					&lt;/div>
				&lt;/div>
		&lt;!-- commentForm -->
		&lt;form class="comment mb-5">
			&lt;legend class="comment-tit">댓글쓰기&lt;/legend>
			&lt;div class="card bg-light">
				&lt;div class="card-body comment-body">
					&lt;!-- comment list -->
					&lt;div class="comment-list">
						&lt;ul class="ul depth1 clearfix">
							&lt;li class="li">
								&lt;div class="depth-row">
									&lt;div class="comment-content">
										&lt;div class="imgbox">
											&lt;div class="img-in no-img">
												&lt;!-- no-img일때  -->
												&lt;img src="./resources/images/prog/navi.jpg"
													alt="작성자프로필이미지">
												&lt;!-- no-img일때  -->
											&lt;/div>
										&lt;/div>
										&lt;div class="writebox">
											&lt;span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고
												싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요&lt;/span>
										&lt;/div>
	
	
									&lt;/div>
									&lt;div class="comment-info d-flex justify-content-between">
	
										&lt;div class="left  d-flex ">
											&lt;span class="comment-writer">
												&lt;i class="icon writer">&lt;/i>
												&lt;em>유길상(개발1팀)&lt;/em>
											&lt;/span>
											&lt;span class="comment-date  ms-4">
												&lt;i class="icon date">&lt;/i>2024.01.03&lt;/span>
	
	
										&lt;/div>
										&lt;button type="button" class="btn btn-danger ms-1"
											data-bs-toggle="modal"
											data-bs-target="#exampleModal">삭제&lt;/button>
									&lt;/div>
								&lt;/div>
								&lt;!-- depth2 -->
								&lt;ul class="ul depth2 border-top">
									&lt;li>
										&lt;div class="depth-row">
											&lt;div class="comment-content">
												&lt;div class="imgbox">
													&lt;div class="img-in no-img">
														&lt;!-- no-img일때  -->
														&lt;img src="./resources/images/prog/navi.jpg"
															alt="작성자프로필이미지">
														&lt;!-- no-img일때  -->
													&lt;/div>
												&lt;/div>
												&lt;div class="writebox">
													&lt;span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
														집에가고 싶어요
														집에가고 싶어요&lt;/span>
												&lt;/div>
	
											&lt;/div>
										&lt;/div>
										&lt;div class="comment-info d-flex justify-content-between">
	
											&lt;div class="left  d-flex ">
												&lt;span class="comment-writer">
													&lt;i class="icon writer">&lt;/i>
													&lt;em>유길상(개발1팀)&lt;/em>
												&lt;/span>
												&lt;span class="comment-date  ms-4">
													&lt;i class="icon date">&lt;/i>2024.01.03&lt;/span>
	
	
											&lt;/div>
											&lt;button type="button" class="btn btn-danger ms-1"
												data-bs-toggle="modal"
												data-bs-target="#exampleModal">삭제&lt;/button>
										&lt;/div>
									&lt;/li>
	
								&lt;/ul>
								&lt;!-- depth2 -->
							&lt;/li>
							&lt;li class="li border-top">
								&lt;div class="depth-row">
									&lt;div class="comment-content">
										&lt;div class="imgbox">
											&lt;div class="img-in no-img">
												&lt;!-- no-img일때  -->
												&lt;img src="./resources/images/prog/navi.jpg"
													alt="작성자프로필이미지">
												&lt;!-- no-img일때  -->
											&lt;/div>
										&lt;/div>
										&lt;div class="writebox">
											&lt;span>집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고
												싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요 집에가고 싶어요
												집에가고 싶어요&lt;/span>
										&lt;/div>
	
									&lt;/div>
									&lt;div class="comment-info d-flex justify-content-between">
	
										&lt;div class="left  d-flex ">
											&lt;span class="comment-writer">
												&lt;i class="icon writer">&lt;/i>
												&lt;em>유길상(개발1팀)&lt;/em>
											&lt;/span>
											&lt;span class="comment-date  ms-4">
												&lt;i class="icon date">&lt;/i>2024.01.03&lt;/span>
										&lt;/div>
										&lt;button type="button" class="btn btn-danger ms-1"
											data-bs-toggle="modal"
											data-bs-target="#exampleModal">삭제&lt;/button>
									&lt;/div>
								&lt;/div>
							&lt;/li>
						&lt;/ul>
	
					&lt;/div>
					&lt;!-- comment list -->
					&lt;!-- comment-input -->
					&lt;div class="d-flex mb-4 comment-input w-100">
						&lt;label for="textarea">&lt;span class="sr-only">댓글입력창&lt;/span>&lt;/label>
						&lt;textarea class="form-control" rows="5" placeholder="댓글을 입력해주세요"
							id="textarea">&lt;/textarea>
						&lt;input class="btn btn-secondary register" type="submit" value="등록">
					&lt;/div>
					&lt;!-- comment-input -->
	
				&lt;/div>
			&lt;/div>
		&lt;/form>
		&lt;!-- commentForm -->
		&lt;!-- Modal -->
		&lt;div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
			aria-hidden="true">
			&lt;div class="modal-dialog">
				&lt;div class="modal-content">
					&lt;div class="modal-header">
						&lt;strong class="modal-title fs-5" id="exampleModalLabel">안내&lt;/strong>
						&lt;button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close">&lt;/button>
					&lt;/div>
					&lt;div class="modal-body">
						"댓글을 삭제하시겠습니까?"
					&lt;/div>
					&lt;div class="modal-footer">
						&lt;button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기&lt;/button>
						&lt;button type="button" class="btn btn-primary">확인&lt;/button>
					&lt;/div>
				&lt;/div>
			&lt;/div>
		&lt;/div>
		&lt;!-- modal -->
		&lt;!-- commentForm -->	
							
			&lt;/div>
	
		&lt;/div>
		&lt;!-- project veiw -->
		&lt;!-- button -->
		&lt;div class="btn-box clearfix mt-4">
			&lt;button class="btn btn-secondary">목록&lt;/button>
			&lt;div class="right float-end">
				&lt;!-- &lt;button class="btn btn-danger">취소&lt;/button> -->
				&lt;button class="btn btn-danger">삭제&lt;/button>
				&lt;button class="btn btn-primary">수정&lt;/button>
			&lt;/div>
		&lt;/div>
	&lt;!-- button -->
	
						&lt;!-- ui : 포토공간목록 e -->
		<!-- Code END -->
								</code>
							</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 05 포토공간상세-->

			<!-- ui 06 alarm-->
			<div class="ui" id="ui18">
				<strong class="ui-tit p-4">알림설정 게시판</strong>
				<div class="content">
					<div class="inner html">
						<!-- ui : s -->

						<!--  alram -->
						<div class="alramBoard board"  id="alram">
							<div class="row mb-3">
								<div class="col-md-6 text-start">
									<button class="btn btn-primary btn-sm">전체읽음</button>
									<button class="btn btn-danger btn-sm">전체삭제</button>
								</div>
								<!-- 알림설정버튼 -->
								<div class="col-md-6 text-end">
									<button class="btn" data-bs-toggle="modal" data-bs-target="#settingmodal">
										<i class="bi bi-gear-fill"></i>
										<span class="sr-only">알림유형 설정버튼</span>
									</button>
								</div>
								<!-- 알림설정버튼 -->
							</div>
							<table class="table text-center">
								<caption class="sr-only">
									게시판별 알림설정 테이블입니다.
								</caption>
								<colgroup>
									<col style="width:5%">
									<col style="width:10%">
									<col style="width:15%">
									<col style="width:35%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:15%">
								</colgroup>
								<thead>
									<th>
										<input type="checkbox">
									</th>
									<th>번호</th>
									<th>알림타입ID</th>
									<th>내용</th>
									<th>읽음확인</th>
									<th>발생일</th>
									<th>삭제</th>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox"></td>
										<td><span>000001</span></td>
										<td><span>나눔공간</span></td>
										<td class="text-start"><a href="#" class="text-link"><em
													class="text-elipsis">게시판에
													새로운 글이 등록되었습니다. 게시판에 새로운 글이 등록되었습니다.게시판에 새로운 글이 등록되었습니다.게시판에 새로운 글이
													등록되었습니다.게시판에 새로운 글이 등록되었습니다.게시판에 새로운 글이 등록되었습니다.게시판에 새로운 글이
													등록되었습니다.게시판에
													새로운 글이 등록되었습니다.게시판에 새로운 글이 등록되었습니다.</em></a></td>
										<td><span>읽음</span></td>
										<td><span>2024-12-31 13:14</span></td>
										<td><button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
												data-bs-target="#deletemodal">삭제</button></td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td><span>2</span></td>
										<td><span>일감배정</span></td>
										<td class="text-start"><a href="#">새로운 일감을 배정 받았습니다.</a></td>
										<td><span>읽음</span></td>
										<td><span>2024-12-31 11:10</span></td>
										<td><button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
												data-bs-target="#deletemodal">삭제</button></td>
									</tr>
								</tbody>
							</table>
							<!-- delete modal -->
							<div class="modal fade" id="deletemodal" tabindex="-1" aria-labelledby="deletemodalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-body text-center mt-5 mb-5">
											<p>삭제하시겠습니까?</p>
											<button type="button" class="btn btn-danger"
												data-bs-dismiss="modal">취소</button>
											<button type="button" class="btn btn-primary">확인</button>
										</div>
									</div>
								</div>
							</div>
							<!-- setting modal -->
							<div class="modal fade" id="settingmodal" tabindex="-1" aria-labelledby="settingmodalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header bg-primary mb-1">
											<strong class="modal-title text-white" id="exampleModalLabel">알림설정</strong>
										</div>
										<div class="modal-body">
											<div class="alrambox">
												<ul class="table-bordered ming-sun text-center align-middle mb-0">
													<li class="d-flex justify-content-between py-2 border-bottom">
														<span>공지게시판 알림</span>
														<div class="wk_con form-check form-switch">
															<input class="form-check-input" type="checkbox"
																role="switch" id="noticeAlram" checked="">
															<label class="form-check-label" for="noticeAlram">on</label>
														</div>

													</li>
													<li class="d-flex justify-content-between py-2 border-bottom">
														<span>서식게시판 알림</span>
														<div class="wk_con form-check form-switch">
															<input class="form-check-input" type="checkbox"
																role="switch" id="formAlram" checked="">
															<label class="form-check-label" for="formAlram">on</label>
														</div>
													</li>
													<li class="d-flex justify-content-between py-2">
														<span>댓글 알림</span>
														<div class="wk_con form-check form-switch">
															<input class="form-check-input" type="checkbox"
																role="switch" id="newAlram" checked="">
															<label class="form-check-label" for="newAlram">on</label>
														</div>
													</li>
												</ul>
											</div>
											<div class="modal-footer justify-content-center">
												<button type="button" class="btn btn-light btn-outline-secondary"
													data-bs-dismiss="modal"> 닫기</button>
												<button type="button" class="btn btn-primary">확인</button>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
						<!--alram -->
						<!-- ui : e -->
					</div>
				</div>

				<!-- html -->
				<div class="content">
					<strong class="tit con-tit">HTML</strong>
					<button class="btn btn-primary copy" id="">복사</button>
					<div class="inner code">
						<pre>
									<code data-clipboard-text="">
				<!-- Code Start -->
				&lt;!--  alram -->
				&lt;div class="alramBoard board"  id="alram">
					&lt;div class="row mb-3">
						&lt;div class="col-md-6 text-start">
							&lt;button class="btn btn-primary btn-sm">전체읽음&lt;/button>
							&lt;button class="btn btn-danger btn-sm">전체삭제&lt;/button>
						&lt;/div>
						&lt;!-- 알림설정버튼 -->
						&lt;div class="col-md-6 text-end">
							&lt;button class="btn" data-bs-toggle="modal" data-bs-target="#settingmodal">
								&lt;i class="bi bi-gear-fill">&lt;/i>
								&lt;span class="sr-only">알림유형 설정버튼&lt;/span>
							&lt;/button>
						&lt;/div>
						&lt;!-- 알림설정버튼 -->
					&lt;/div>
					&lt;table class="table text-center">
						&lt;caption class="sr-only">
							게시판별 알림설정 테이블입니다.
						&lt;/caption>
						&lt;colgroup>
							&lt;col style="width:5%">
							&lt;col style="width:10%">
							&lt;col style="width:15%">
							&lt;col style="width:35%">
							&lt;col style="width:10%">
							&lt;col style="width:10%">
							&lt;col style="width:15%">
						&lt;/colgroup>
						&lt;thead>
							&lt;th>
								&lt;input type="checkbox">
							&lt;/th>
							&lt;th>번호&lt;/th>
							&lt;th>알림타입ID&lt;/th>
							&lt;th>내용&lt;/th>
							&lt;th>읽음확인&lt;/th>
							&lt;th>발생일&lt;/th>
							&lt;th>삭제&lt;/th>
						&lt;/thead>
						&lt;tbody>
							&lt;tr>
								&lt;td>&lt;input type="checkbox">&lt;/td>
								&lt;td>&lt;span>000001&lt;/span>&lt;/td>
								&lt;td>&lt;span>나눔공간&lt;/span>&lt;/td>
								&lt;td class="text-start">&lt;a href="#" class="text-link">&lt;em class="text-elipsis">게시판에
											새로운 글이 등록되었습니다. 게시판에 새로운 글이 등록되었습니다.게시판에 새로운 글이 등록되었습니다.게시판에 새로운 글이
											등록되었습니다.게시판에 새로운 글이 등록되었습니다.게시판에 새로운 글이 등록되었습니다.게시판에 새로운 글이 등록되었습니다.게시판에
											새로운 글이 등록되었습니다.게시판에 새로운 글이 등록되었습니다.&lt;/em>&lt;/a>&lt;/td>
								&lt;td>&lt;span>읽음&lt;/span>&lt;/td>
								&lt;td>&lt;span>2024-12-31 13:14&lt;/span>&lt;/td>
								&lt;td>&lt;button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
										data-bs-target="#deletemodal">삭제&lt;/button>&lt;/td>
							&lt;/tr>
							&lt;tr>
								&lt;td>&lt;input type="checkbox">&lt;/td>
								&lt;td>&lt;span>2&lt;/span>&lt;/td>
								&lt;td>&lt;span>일감배정&lt;/span>&lt;/td>
								&lt;td class="text-start">&lt;a href="#">새로운 일감을 배정 받았습니다.&lt;/a>&lt;/td>
								&lt;td>&lt;span>읽음&lt;/span>&lt;/td>
								&lt;td>&lt;span>2024-12-31 11:10&lt;/span>&lt;/td>
								&lt;td>&lt;button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
										data-bs-target="#deletemodal">삭제&lt;/button>&lt;/td>
							&lt;/tr>
						&lt;/tbody>
					&lt;/table>
					&lt;!-- delete modal -->
					&lt;div class="modal fade" id="deletemodal" tabindex="-1" aria-labelledby="deletemodalLabel"
						aria-hidden="true">
						&lt;div class="modal-dialog">
							&lt;div class="modal-content">
								&lt;div class="modal-body text-center mt-5 mb-5">
									&lt;p>삭제하시겠습니까?&lt;/p>
									&lt;button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소&lt;/button>
									&lt;button type="button" class="btn btn-primary">확인&lt;/button>
								&lt;/div>
							&lt;/div>
						&lt;/div>
					&lt;/div>
					&lt;!-- setting modal -->
					&lt;div class="modal fade" id="settingmodal" tabindex="-1" aria-labelledby="settingmodalLabel"
						aria-hidden="true">
						&lt;div class="modal-dialog">
							&lt;div class="modal-content">
								&lt;div class="modal-header bg-primary mb-1">
									&lt;strong class="modal-title text-white" id="exampleModalLabel">알림설정&lt;/strong>
								&lt;/div>
								&lt;div class="modal-body">
									&lt;div class="alrambox">
										&lt;ul class="table-bordered ming-sun text-center align-middle mb-0">
											&lt;li class="d-flex justify-content-between py-2 border-bottom">
												&lt;span>공지게시판 알림&lt;/span>
												&lt;div class="wk_con form-check form-switch">
													&lt;input class="form-check-input" type="checkbox" role="switch"
														id="noticeAlram" checked="">
													&lt;label class="form-check-label" for="noticeAlram">on&lt;/label>
												&lt;/div>

											&lt;/li>
											&lt;li class="d-flex justify-content-between py-2 border-bottom">
												&lt;span>서식게시판 알림&lt;/span>
												&lt;div class="wk_con form-check form-switch">
													&lt;input class="form-check-input" type="checkbox" role="switch"
														id="formAlram" checked="">
													&lt;label class="form-check-label" for="formAlram">on&lt;/label>
												&lt;/div>
											&lt;/li>
											&lt;li class="d-flex justify-content-between py-2">
												&lt;span>댓글 알림&lt;/span>
												&lt;div class="wk_con form-check form-switch">
													&lt;input class="form-check-input" type="checkbox" role="switch"
														id="newAlram" checked="">
													&lt;label class="form-check-label" for="newAlram">on&lt;/label>
												&lt;/div>
											&lt;/li>
										&lt;/ul>
									&lt;/div>
									&lt;div class="modal-footer justify-content-center">
										&lt;button type="button" class="btn btn-light btn-outline-secondary"
											data-bs-dismiss="modal"> 닫기&lt;/button>
										&lt;button type="button" class="btn btn-primary">확인&lt;/button>
									&lt;/div>
								&lt;/div>

							&lt;/div>
						&lt;/div>
					&lt;/div>
				&lt;/div>
				&lt;!--alram -->

				<!-- Code END -->
									</code>
								</pre>
					</div>
				</div>
				<!-- html -->
			</div>
			<!-- ui 06 alarm-->

		

		</div>
		<!-- section01-->

	</div>
	<!-- wrap -->
</body>

</html>