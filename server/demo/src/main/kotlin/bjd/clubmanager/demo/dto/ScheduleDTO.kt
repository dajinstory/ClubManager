package bjd.clubmanager.demo.dto

import bjd.clubmanager.demo.model.Schedule
import org.springframework.beans.factory.annotation.Autowired


data class ScheduleDTO @Autowired constructor(
    val clubId: Long,
    val id: Long? = null,
    val writer: String,
    val title: String,
    val startTime: String,
    val duration: String
) {
    fun toEntity(): Schedule {
        return Schedule(
            clubId = clubId,
            id = id,
            writer = writer,
            title = title,
            startTime = startTime,
            duration = duration
        )
    }
}

data class ScheduleClubIdDTO @Autowired constructor(
    val clubId: Long,
) {
    fun toScheduleClubIdEntity(): Long {
        return clubId
    }
}



