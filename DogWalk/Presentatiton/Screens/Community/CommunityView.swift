//
//  CommunityView.swift
//  DogWalk
//
//  Created by junehee on 10/30/24.
//

import SwiftUI

//더미 데이터 구조체 추후 삭제
struct CummunityTestData: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String
    var content: String
    var createdAt: String
    var commentCount: Int
    var likeCount: Int
    
    init(title: String = "우리 강아지 예쁘죠?",
         content: String = "오늘 탄실이 미용했어요. 털 밀었다고 삐져있네요. 뾰로퉁한 표정도 귀여워요~~~~~",
         createdAt: String = "24.10.11",
         commentCount: Int = 123,
         likeCount: Int = 12) {
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.commentCount = commentCount
        self.likeCount = likeCount
    }
}

struct CommunityView: View {
    static private let width = UIScreen.main.bounds.width
    static private let height = UIScreen.main.bounds.height
    @State private var isShowingSheet = false
    @State private var items = (0..<10).map { _ in CummunityTestData() } // 테스트 데이터 배열, 실제 데이터로 변경
    private var filterButton = ["전체", "시터구하기", "산책 인증", "궁금해요", "자유게시판"] // MVI 패턴 적용후 Model로 이동
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    filterView()
                    ForEach(items, id: \.id) { item in
                        postViewCell(item) //ListCellView
                    }
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        areaSelectionView() // 좌상단 위치선택(ex.문래동)
                    }
                }
                floatingButton()
            }
            .sheet(isPresented: $isShowingSheet) {
                bottomSheetView() // 문래동 버튼 탭시 올라오는 바텀시트
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.3)])
            }
        }
    }
    
    // 좌상단 버튼 뷰
    private func filterView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(filterButton, id: \.self) { item in
                    filterButtonsView(item)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
    
    private func filterButtonsView(_ buttonTitle: String) -> some View {
        CommonButton(width: Self.width * 0.22,
                     height: Self.height * 0.04,
                     cornerradius: 12,
                     backColor: .primaryLime,
                     text: buttonTitle,
                     textFont: .pretendardBlack15)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primaryBlack, lineWidth: 1)
        }
        .wrapToButton {
            // 우리동네 10km 이내 게시물 필터
        }
    }
    
    // 문래동 버튼 눌렀을 때 올라오는 bottomSheetView
    private func bottomSheetView() -> some View {
        VStack(spacing: 20) {
            Text("동네 범위 설정")
                .padding(.leading)
                .font(.pretendardBold20)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // 전체 게시물 필터 버튼
            CommonButton(width: Self.width * 0.9,
                         height: Self.height * 0.05,
                         cornerradius: 8,
                         backColor: .clear,
                         text: "우리동네(반경 10KM)",
                         textFont: .pretendardRegular19,
                         textColor: .gray)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primaryBlack, lineWidth: 1)
            }
            .wrapToButton {
                // 우리동네 10km 이내 게시물 필터
            }
            
            // 전체 게시물 버튼
            CommonButton(width: Self.width * 0.9,
                         height: Self.height * 0.05,
                         cornerradius: 8,
                         backColor: .primaryOrange.opacity(0.8),
                         text: "모든 동네(전국)",
                         textFont: .pretendardRegular19,
                         textColor: .white)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primaryBlack, lineWidth: 1)
            }
            .wrapToButton {
                // 전체 게시물 조회
            }
            Spacer()
        }
        .padding(.top, 16)
    }
    
    // 좌상단 거리별 리스트 변경 버튼
    private func areaSelectionView() -> some View {
        HStack {
            Button {
                isShowingSheet = true
            } label: {
                Group {
                    Text("문래동")
                        .font(.bagelfat28)
                    Image.asDownChevron
                }
                .foregroundColor(.primaryBlack)
            }
            Spacer()
        }
    }
    
    // PostCell
    private func postViewCell(_ item: CummunityTestData) -> some View {
        HStack {
            Image.asTestImage
                .resizable()
                .scaledToFill()
                .frame(width: Self.width * 0.25, height: Self.width * 0.25)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(item.title) // 제목
                        .font(.pretendardBold16)
                    Spacer()
                    Text(item.createdAt) // 게시된 시간
                        .font(.pretendardRegular12)
                        .foregroundStyle(.gray)
                }
                
                Text(item.content) // 본문
                    .font(.pretendardRegular14)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.leading)
                Spacer()
                HStack {
                    categoryLabel()
                    Spacer()
                    Button {
                        // 댓글 동작 구현
                    } label: {
                        HStack(spacing: 4) {
                            Image.asMessage  // 댓글
                                .foregroundColor(.primaryBlack)
                            Text("\(item.commentCount)") // 댓글 수
                                .font(.pretendardRegular14)
                                .foregroundColor(.gray)
                        }
                        Button {
                            // 좋아요 동작 구현
                        } label: {
                            HStack(spacing: 4) {
                                Image.asHeart
                                    .foregroundColor(.primaryBlack)
                                Text("\(item.likeCount)") // 좋아요 수
                                    .font(.pretendardRegular14)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 4)
            Spacer()
        }
    }
    
    // 카테고리 라벨
    private func categoryLabel() -> some View {
        Text("자유게시판")
                   .font(.pretendardRegular12)
                   .foregroundColor(.white)
                   .padding(.horizontal, 8)
                   .padding(.vertical, 2)
                   .background(
                       RoundedRectangle(cornerRadius: 4)
                           .fill(Color.red.opacity(0.5))
                   )
    }
    
    // Floating Button
    private func floatingButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    // 게시물 추가 동작 구현
                }label: {
                    Image.asPencil
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .frame(width: 60, height: 60)
                        .background(
                            Circle()
                                .fill(Color.primaryGreen)
                        )
                }
                .padding(.bottom)
                .padding(.trailing)
            }
        }
    }
}

#Preview {
    CommunityView()
}
