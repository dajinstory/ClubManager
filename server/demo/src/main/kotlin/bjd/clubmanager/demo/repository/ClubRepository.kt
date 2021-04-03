package bjd.clubmanager.demo.repository

import bjd.clubmanager.demo.model.Club
import org.springframework.data.repository.CrudRepository
import java.util.*

//interface ClubRepository : JpaRepository<Pyun, Long> {
interface ClubRepository : CrudRepository<Club, Long> {
    override fun findAll(): List<Club>
    override fun findById(id: Long): Optional<Club>
}
