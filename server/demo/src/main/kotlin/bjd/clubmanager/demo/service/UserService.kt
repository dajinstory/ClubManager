package bjd.clubmanager.demo.service

import bjd.clubmanager.demo.dto.UserDTO
import bjd.clubmanager.demo.dto.UserIdDTO
import bjd.clubmanager.demo.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
class UserService {
    @Autowired
    lateinit var userRepository: UserRepository

    fun getUsers(): List<UserDTO> {
        val users = userRepository.findAll()
        return users.map { it.toDTO() }
    }

    fun getUserById(userIdDTO: UserIdDTO): UserDTO? {
        val id = userIdDTO.toEntity()
        val user = userRepository.findById(id)
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