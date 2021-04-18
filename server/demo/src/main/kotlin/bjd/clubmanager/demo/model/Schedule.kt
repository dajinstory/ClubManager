package bjd.clubmanager.demo.model

import bjd.clubmanager.demo.dto.ScheduleDTO
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

@Entity
data class Schedule (
    val clubId: Long,
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    val writer: String,
    val title: String,
    val startTime: String,
    val duration: String
) {
    fun toDTO() : ScheduleDTO {
        return ScheduleDTO(
            clubId = clubId,
            id = id,
            writer = writer,
            title = title,
            startTime = startTime,
            duration = duration
        )
    }
}
