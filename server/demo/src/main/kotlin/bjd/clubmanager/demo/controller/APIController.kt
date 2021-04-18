package bjd.clubmanager.demo.controller

import bjd.clubmanager.demo.dto.*
import bjd.clubmanager.demo.service.*
import lombok.RequiredArgsConstructor
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RequiredArgsConstructor
@RestController
class APIController {
    @Autowired
    private lateinit var userService: UserService
    @Autowired
    private lateinit var clubService: ClubService
    @Autowired
    private lateinit var memberService: MemberService
    @Autowired
    private lateinit var boardService: BoardService
    @Autowired
    private lateinit var postService: PostService
    @Autowired
    private lateinit var scheduleService: ScheduleService

    // 회원가입 - create user
    @PostMapping("/user")
    fun createUser(@RequestBody userDTO: UserDTO): ResponseEntity<Any> {
        userService.createUser(userDTO)
        return ResponseEntity
            .ok()
            .body(true)
    }
    // MYPAGE - 내 카페, 아이디
    @GetMapping("/user", produces = ["application/json"])
    fun getUser(@RequestHeader email: String?): ResponseEntity<Any> {
        // Get All
        return if (email == null) {
            print("FindALL")
            return ResponseEntity
                .ok()
                .body(userService.getUsers())
        } else ResponseEntity
            .ok()
            .body(userService.getUserByKey(UserKeyDTO(-1, email!!)))
    }

    // CLUB 생성 - create club
    @PostMapping("/club")
    fun createClub(@RequestBody clubDTO: ClubDTO): ResponseEntity<Any> {
        clubService.createClub(clubDTO)
        return ResponseEntity
            .ok()
            .body(true)
    }
    // CLUB 홈페이지
    @GetMapping("/club", produces = ["application/json"])
    fun getClubs(@RequestBody userClubsDTO: UserClubsDTO?): ResponseEntity<Any> {
        return if(userClubsDTO == null){
            ResponseEntity.ok().body(clubService.getClubs())
        } else{
            ResponseEntity
                .ok()
                .body(clubService.getClubsById(userClubsDTO))
        }
    }

    // BOARD 생성 - create board
    @PostMapping("/board")
    fun createBoard(@RequestBody boardDTO: BoardDTO): ResponseEntity<Any> {
        boardService.createBoard(boardDTO)
        return ResponseEntity
            .ok()
            .body(true)
    }
    // BOARD LIST
    @GetMapping("/board", produces = ["application/json"])
    fun getBoards(@RequestBody clubIdDTO: ClubIdDTO): ResponseEntity<Any> {
        return ResponseEntity
            .ok()
            .body(boardService.getBoardsByClubId(clubIdDTO))
    }

    // POST 생성 - create post
    @PostMapping("/post")
    fun createPost(@RequestBody postDTO: PostDTO): ResponseEntity<Any> {
        postService.createPost(postDTO)
        return ResponseEntity
            .ok()
            .body(true)
    }
    // POST LIST
    @GetMapping("/post", produces = ["application/json"])
    fun getPosts(@RequestBody boardIdDTO: BoardIdDTO): ResponseEntity<Any> {
        return ResponseEntity
            .ok()
            .body(postService.getPostsByBoardId(boardIdDTO))
    }

    // Create Scheduler
    @PostMapping("/schedule")
    fun createSchedule(@RequestBody scheduleDTO: ScheduleDTO): ResponseEntity<Any> {
        scheduleService.createSchedule(scheduleDTO)
        return ResponseEntity
            .ok()
            .body(true)
    }
    // Search Schedule
    @GetMapping("/schedule", produces = ["application/json"])
    fun getSchedule(@RequestBody scheduleClubIdDTO: ScheduleClubIdDTO): ResponseEntity<Any> {
        // Get All
        return ResponseEntity
            .ok()
            .body(scheduleService.getSchedulesByClubId(scheduleClubIdDTO))
    }
}
