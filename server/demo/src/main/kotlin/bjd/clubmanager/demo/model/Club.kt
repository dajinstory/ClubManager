package bjd.clubmanager.demo.model

import bjd.clubmanager.demo.dto.ClubDTO
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

@Entity
data class Club (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    val name: String,
    val president: Long
) {
    fun toDTO() : ClubDTO {
        return ClubDTO(
            id = id,
            name = name,
            president = president
        )
    }
}
