package bjd.clubmanager.demo.service

import bjd.clubmanager.demo.dto.ScheduleClubIdDTO
import bjd.clubmanager.demo.dto.ScheduleDTO
import bjd.clubmanager.demo.repository.ScheduleRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
class ScheduleService {
    @Autowired
    lateinit var scheduleRepository: ScheduleRepository

    fun getSchedulesByClubId(scheduleClubIdDTO: ScheduleClubIdDTO): List<ScheduleDTO> {
        val clubId = scheduleClubIdDTO.toScheduleClubIdEntity()
        val schedules = scheduleRepository.findSchedulesByClubId(clubId)
        return schedules.map{it.toDTO()}
    }

    @Transactional
    fun createSchedule(scheduleDTO: ScheduleDTO) : ScheduleDTO {
        val schedule = scheduleRepository.save(scheduleDTO.toEntity())
        return schedule.toDTO()
    }
}