package bjd.clubmanager.demo.repository

import bjd.clubmanager.demo.model.Schedule
import org.springframework.data.repository.CrudRepository

interface ScheduleRepository : CrudRepository<Schedule, Long> {
    override fun findAll(): List<Schedule>
    fun findSchedulesByClubId(clubId:Long): List<Schedule>
}
