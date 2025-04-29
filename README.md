# See Near

**Spring Boot 기반 시니어 실시간 건강 모니터링 헬스케어 시스템**
(WebSocket, AI Chatbot, WebRTC)

> 시니어의 건강을 실시간으로 모니터링하고, 보호자 및 요양 보호사와의 신속한 소통을 지원하는 통합 헬스케어 플랫폼입니다.

## 📌 프로젝트 개요
### 기획 의도
- 시니어들이 독립적인 생활을 유지하면서도 안전하게 지낼 수 있도록 지원
- 보호자와 요양 보호사 간의 실시간 소통 및 관리 필요성 증대

### 차별화 포인트
- 웨어러블 기기를 도입해 실시간 건강 상태 모니터링 및 예방적 조치 가능
- 상태 변화 발생 시 신속한 알림 및 대응 체계 구축
- 위치 정보 및 건강 데이터를 기반으로 한 안전 관리 및 삶의 질 향상
- WebRTC 및 업무일지 작성을 통한 보호자-보호사 소통 강화
  
### 주요 기능
- 웨어러블 기기를 통한 실시간 건강 데이터 수집
- 위치 기반 보호사 매칭 및 계약 관리
- WebRTC 기반 1:1 화상 통화
- AI 챗봇을 통한 상담 서비스 지원 (다국어 지원)
- 관리자 대시보드를 통한 시스템 모니터링

기간: 2024.10.25~2024.12.20

## 🧑‍💻 팀원 및 역할

| 이름 (포지션) | 담당 업무 |
|:-------------|:-----|
| 서효석 (PL, Full Stack) | 프로젝트 총괄 기획 및 리딩, 시스템 설계, 백엔드 통합 관리 |
| 조현열 (Full Stack) | Admin 모듈 총괄, 모니터링 기능 개발 |
| 이태빈 (Front-end) | 프론트엔드 UI/UX 구현, 고객/보호사 UI 개발 및 반응형 웹 구현 |
| 이동우 (Back-end) | 시니어 건강 이력 차트, 실시간 위치/건강 모니터링 기능 개발 |
| 진완규 (Back-end) | 회원가입 및 로그인, WebSocket 기반 소통 기능, 챗봇 API 연동 개발 |

## 🎯 기술 스택
- **Frontend**: HTML5, CSS3, JavaScript(ES6), Bootstrap(v4.5.2), JSP, WebRTC
- **Backend**: Java 17, Spring Boot v3.2.11, MyBatis, WebSocket, XML
- **Database**: MySQL v8.0.37
- **Logging & Test**: Log4jdbc, JUnit5
- **보안 및 암호화**: Spring Security, Jasypt
- **Deployment**: Apach Tomcat, Naver Cloud Platform 

## 🛠 시스템 구조 (아키텍처, ERD, WBS)
### 시스템 아키텍처
![image](https://github.com/user-attachments/assets/b765f24d-c312-44ec-a14c-85bd16903b7e)
### ERD
![image](https://github.com/user-attachments/assets/d93257a5-425c-4bc5-be03-65d86623ffa7)
### WBS
![image](https://github.com/user-attachments/assets/ef2e2157-9311-4720-b00e-a47b727974ee)
### 업무 흐름도
![image](https://github.com/user-attachments/assets/0fd11947-3ee2-41c5-b9e5-55c991374fa3)
### 요구사항 분석
**Service**

![image](https://github.com/user-attachments/assets/ee4bee08-3c4a-4d57-9841-674c1e162b69)

**Admin**

![image](https://github.com/user-attachments/assets/87155630-6e6e-41f7-9cf3-5af11bb03a7a)

## 🔍 주요 기능 화면

### 메인 페이지
![image](https://github.com/user-attachments/assets/9fe0c319-f73f-4132-8e4a-d096e58c7b50)

: 로그인 후 메인화면. 전체 서비스 진입 지점

## 고객 페이지
![image](https://github.com/user-attachments/assets/9adf6434-9b50-4989-8958-43a908f55fbd)

: 로그인 완료 후 메인페이지. 시니어 미등록 시 강제 리다이렉트, 1:1 채팅 지원

## 보호사 신청 화면
![image](https://github.com/user-attachments/assets/27bf1026-9338-4911-b747-5cd47d44d471)

: 시니어 등록 후, 주변 보호사를 거리순으로 조회하고 신청할 수 있는 화면.

## 계약 신청 화면

![image](https://github.com/user-attachments/assets/6a089d7f-606b-4a3c-9d0a-9369db0f4086)

: 계약 시작일과 종료일, 계약 금액 등을 입력하여 보호사와 계약을 체결하는 화면.

## 캘린더 화면

![image](https://github.com/user-attachments/assets/ba432778-5344-4bb4-a219-8cbf683a2363)

: 일정 관리 기능 제공.

## 병원/약국 지도 화면

![image](https://github.com/user-attachments/assets/2f77e527-3b59-47e3-9b42-37cebe265273)

: 시니어 거주지 주변 병원 및 약국 정보를 지도 기반으로 제공.

## 시니어 상세 화면

![image](https://github.com/user-attachments/assets/7a54e45b-16cb-4b2f-8c5a-9750d1774f06)

: 시니어의 실시간 건강 정보, 위치, 보호사 거리 및 업무일지 관리 기능 제공.

## WebRTC 화상통화 화면

![image](https://github.com/user-attachments/assets/1b974872-044a-4ad5-9ed0-9cd78467f394)

: 고객-보호사 1:1 화상 통화 지원. 계약ID를 이용한 회의방 매칭.

## 보호사 업무일지 화면

![image](https://github.com/user-attachments/assets/2bc08781-29fc-433e-bd03-b51bdc33518e)

: 보호사가 작성하는 시니어 방문 업무일지 화면. 고객은 열람 가능.

## 보호사 모니터링 화면

![image](https://github.com/user-attachments/assets/2e24da32-559d-4e94-adfb-9d91a2f2a9eb)

: 보호사가 관리 중인 시니어들의 위치를 지도상으로 확인 가능.

## 보호사 계약 관리 화면

![image](https://github.com/user-attachments/assets/a6bc2ce8-f3df-4aa3-8fa7-4d9668f45f29)

: 보호사가 계약 상태별(전체/대기중/매칭완료)로 계약 내역을 관리하는 화면.

## 관리자 대시보드

![image](https://github.com/user-attachments/assets/941de868-5f75-47c8-be46-c02ddd304322)

![image](https://github.com/user-attachments/assets/d47293f3-423c-4ce6-bfb4-1199fb6c116f)

: 전체 고객 수, 보호사 수, 채팅 활성도, 서버 자원 추이 모니터링.

## 🗂 프로젝트 계획 및 시나리오
### 프로젝트 계획도
![image](https://github.com/user-attachments/assets/d8a71246-5e68-4efc-9786-fa21b4214cbc)

### 서비스 시나리오
![image](https://github.com/user-attachments/assets/b7ecbac5-a54b-4980-8543-b8e7479ac162)


## 📎 참고 링크
 
- [노션 문서](https://www.notion.so/SW-4-12a3aa17a00680ae8b39c5832ff89557?pvs=21)

- [See Near 프로젝트 소개 영상](https://youtu.be/bZwnYCVVCLo)