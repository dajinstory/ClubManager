package bjd.clubmanager.demo.dto

import bjd.clubmanager.demo.model.Board
import org.springframework.beans.factory.annotation.Autowired

data class BoardDTO @Autowired constructor(
    val clubId: Long,
    val id: Long? = null,
    val name: String,
    val auth: Long
) {
    fun toEntity(): Board {
        return Board(
            clubId = clubId,
            name = name,
            auth = auth
        )
    }
}
data class BoardIdDTO @Autowired constructor(
    val clubId: Long,
    val boardId: Long
) {
    fun toClubEntity(): Long {
        return clubId
    }
    fun toBoardEntity(): Long {
        return boardId
    }
}


