package bjd.clubmanager.demo.model

import bjd.clubmanager.demo.dto.PostDTO
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

@Entity
data class Post (
    val clubId: Long,
    val boardId: Long,
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    val name: String,
    val content: String,
    val writer: Long,
    val comments: String
) {
    fun toDTO() : PostDTO {
        return PostDTO(
            clubId = clubId,
            boardId = boardId,
            id = id,
            name = name,
            content = content,
            writer = writer,
            comments = comments
        )
    }
}
