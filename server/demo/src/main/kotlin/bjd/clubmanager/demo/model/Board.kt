package bjd.clubmanager.demo.model

import bjd.clubmanager.demo.dto.BoardDTO
import javax.persistence.GeneratedValue
import javax.persistence.*

@Entity
data class Board (
    val clubId: Long,
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    val name: String,
    val auth: Long
) {
    fun toDTO() : BoardDTO {
        return BoardDTO(
            clubId = clubId,
            id = id,
            name = name,
            auth = auth
        )
    }
}
