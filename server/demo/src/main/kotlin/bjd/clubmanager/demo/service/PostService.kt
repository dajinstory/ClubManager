package bjd.clubmanager.demo.service

import bjd.clubmanager.demo.dto.BoardDTO
import bjd.clubmanager.demo.dto.BoardIdDTO
import bjd.clubmanager.demo.dto.ClubDTO
import bjd.clubmanager.demo.dto.PostDTO
import bjd.clubmanager.demo.model.Post
import bjd.clubmanager.demo.repository.BoardRepository
import bjd.clubmanager.demo.repository.PostRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
class PostService {
    @Autowired
    lateinit var postRepository: PostRepository

    fun getPostsByBoardId(boardIdDTO: BoardIdDTO): List<PostDTO> {
        val clubId = boardIdDTO.toClubEntity()
        val boardId = boardIdDTO.toBoardEntity()
        lateinit var posts: List<Post>

        // Find by ClubId
        posts = if( boardId == (-1).toLong() ){
            postRepository.findPostsByClubId(clubId)
        } else {
            postRepository.findPostsByBoardId(boardId)
        }

        return posts.map{it.toDTO()}
    }

    fun getPostById(postDTO: PostDTO): PostDTO? {
        val id = postDTO.toEntity().id
        val post = postRepository.findById(id!!)
        return if(post.isEmpty){
            null
        } else post.get().toDTO()
    }

    @Transactional
    fun createPost(postDTO: PostDTO) : PostDTO {
        val post = postRepository.save(postDTO.toEntity())
        return post.toDTO()
    }
}