package bjd.clubmanager.demo.repository

import bjd.clubmanager.demo.model.User
import org.springframework.data.repository.CrudRepository
import java.util.*

interface UserRepository : CrudRepository<User, Long> {
    override fun findAll(): List<User>
    override fun findById(id: Long): Optional<User>
}
