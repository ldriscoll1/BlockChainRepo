import { useEffect, useState } from "react";
import { snail_game_contract } from "@../../util/contractdetails";
import styles from '../../styles/Home.module.css';

export default function Leaderboard() {
	const [leaderboard, setLeaderboard] = useState([]);
	const [loading, setLoading] = useState(true);

	async function getLeaderBoardSize() {
		const leaderboardSize = await snail_game_contract.getLeaderboardLength();
		return leaderboardSize;
	}

	async function getLeaderboardData(index) {
		const leaderboardData = await snail_game_contract.getLeaderboardEntry(index);
		return {
			Address1: leaderboardData[0],
			Address2: leaderboardData[1],
			Time: parseInt(leaderboardData[2])
		};
	}
	useEffect(() => {
		//get size of leaderboard
		setLoading(true);
		console.log(loading);
		(async () => {
			const leaderboardSize = await getLeaderBoardSize();
			//for loop leaderboard based on size
			const leaderboardList = [];
			for(let i = 0; i < leaderboardSize; i++){
				//get leaderboard data
				const leaderboardData = await getLeaderboardData(i);
				//append record to array
				leaderboardList.push(leaderboardData);
			}
			//set leaderboard state
			setLeaderboard(leaderboardList);
		})();
		setTimeout(() => {
			setLoading(false);
		}, 2000);
	}, []);
	return (
		<div className={styles.leaderboard}>
		<h1>Leaderboard</h1>
			{loading ? <p>Loading...</p> : 
			<table>
				<thead>
					<tr>
						<th>Rank</th>
						<th>Address 1</th>
						<th>Address 2</th>
						<th>Time</th>
					</tr>
				</thead>
				<tbody>
					{leaderboard.map((entry, index) => (
							<tr key={index}>
								<td>{index+1}</td>
								<td>{entry.Address1}</td>
								<td>{entry.Address2}</td>
								<td>{entry.Time} Seconds</td>
							</tr>
						)
					)}
				</tbody>
			</table>
			}
		</div>
	);
}
