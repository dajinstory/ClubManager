package bjd.clubmanager.demo.service

import bjd.clubmanager.demo.dto.BoardDTO
import bjd.clubmanager.demo.dto.ClubDTO
import bjd.clubmanager.demo.dto.ClubIdDTO
import bjd.clubmanager.demo.repository.BoardRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
class BoardService {
    @Autowired
    lateinit var boardRepository: BoardRepository

    fun getBoardsByClubId(clubIdDTO: ClubIdDTO): List<BoardDTO> {
        val clubId = clubIdDTO.toEntity()
        val boards = boardRepository.findBoardsByClubId(clubId!!)
        return boards.map{it.toDTO()}
    }

    @Transactional
    fun createBoard(boardDTO: BoardDTO) : BoardDTO {
        val board = boardRepository.save(boardDTO.toEntity())
        return board.toDTO()
    }
}