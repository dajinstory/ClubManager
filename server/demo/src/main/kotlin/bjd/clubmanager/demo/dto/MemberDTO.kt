package bjd.clubmanager.demo.dto

import bjd.clubmanager.demo.model.Member
import org.springframework.beans.factory.annotation.Autowired

//TBD : convert to per club schema
data class MemberDTO @Autowired constructor(
    val memberId: Long? = null,
    val clubId: Long,
    val userId: Long,
    val name: String,
    val auth: Long,

) {
    fun toEntity(): Member {
        return Member(
            clubId = clubId,
            userId = userId,
            name = name,
            auth = auth
        )
    }
}

