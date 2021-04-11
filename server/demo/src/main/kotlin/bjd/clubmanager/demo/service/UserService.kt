package bjd.clubmanager.demo.service

import bjd.clubmanager.demo.dto.BoardIdDTO
import bjd.clubmanager.demo.dto.PostDTO
import bjd.clubmanager.demo.dto.UserDTO
import bjd.clubmanager.demo.dto.UserKeyDTO
import bjd.clubmanager.demo.model.Post
import bjd.clubmanager.demo.model.User
import bjd.clubmanager.demo.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Component
class UserService {
    @Autowired
    lateinit var userRepository: UserRepository

    fun getUsers(): List<UserDTO> {
        val users = userRepository.findAll()
        return users.map { it.toDTO() }
    }

    fun getUserByKey(userKeyDTO: UserKeyDTO): UserDTO? {
        val id = userKeyDTO.toIdEntity()
        val email = userKeyDTO.toEmailEntity()
        var user: Optional<User>

        // Find by Email
        user = if( id == (-1).toLong() ){
            userRepository.findByEmail(email)
        } else {
            userRepository.findById(id)
        }

        return if(user.isEmpty){
            null
        } else user.get().toDTO()
    }

    fun getUserById(userKeyDTO: UserKeyDTO): UserDTO? {
        val id = userKeyDTO.toIdEntity()
        val user = userRepository.findById(id)
        return if(user.isEmpty){
            null
        } else user.get().toDTO()
    }

    fun getUserByEmail(userKeyDTO: UserKeyDTO): UserDTO? {
        val email = userKeyDTO.toEmailEntity()
        val user = userRepository.findByEmail(email)
        return if(user.isEmpty){
            null
        } else user.get().toDTO()
    }

    @Transactional
    fun createUser(userDTO: UserDTO) : UserDTO {
        val user = userRepository.save(userDTO.toEntity())
        return user.toDTO()
    }
}