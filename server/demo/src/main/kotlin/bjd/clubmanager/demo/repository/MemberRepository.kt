package bjd.clubmanager.demo.repository

import bjd.clubmanager.demo.model.Member
import org.springframework.data.repository.CrudRepository

interface MemberRepository : CrudRepository<Member, Long> {
    override fun findAll(): List<Member>
    fun findAllByClubIdEquals(clubId:Long): List<Member>
}
