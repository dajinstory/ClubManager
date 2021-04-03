package bjd.clubmanager.demo.repository

import bjd.clubmanager.demo.model.Board
import org.springframework.data.repository.CrudRepository

interface BoardRepository : CrudRepository<Board, Long> {
    override fun findAll(): List<Board>
    fun findBoardsByClubId(clubId:Long): List<Board>
}
