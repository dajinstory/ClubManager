package bjd.clubmanager.demo.dto

import bjd.clubmanager.demo.model.Post
import org.springframework.beans.factory.annotation.Autowired


data class PostDTO @Autowired constructor(
    val clubId: Long,
    val boardId: Long,
    val id: Long? = null,
    val name: String,
    val content: String,
    val writer: Long,
    val comments: String
) {
    fun toEntity(): Post {
        return Post(
            clubId = clubId,
            boardId = boardId,
            name = name,
            content = content,
            writer = writer,
            comments = comments
        )
    }
}

