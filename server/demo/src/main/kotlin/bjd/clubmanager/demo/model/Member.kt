package bjd.clubmanager.demo.model

import bjd.clubmanager.demo.dto.MemberDTO
import javax.lang.model.element.Name
import javax.persistence.*


@Entity
data class Member (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val memberId: Long? = null,
    val clubId: Long,
    val userId: Long,
    val name: String,
    val auth: Long
) {
    fun toDTO() : MemberDTO {
        return MemberDTO(
            memberId = memberId,
            clubId = clubId,
            userId = userId,
            name = name,
            auth = auth
        )
    }
}