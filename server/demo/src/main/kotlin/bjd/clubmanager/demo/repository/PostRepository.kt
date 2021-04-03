package bjd.clubmanager.demo.repository

import bjd.clubmanager.demo.model.Post
import org.springframework.data.repository.CrudRepository
import java.util.*

interface PostRepository : CrudRepository<Post, Long> {
    override fun findAll(): List<Post>
    override fun findById(id: Long): Optional<Post>
    fun findPostsByClubId(clubId:Long): List<Post>
    fun findPostsByBoardId(boardId:Long): List<Post>
}
